using System.Collections.Concurrent;
using System.Net;
using FluentAssertions;
using Microsoft.AspNetCore.TestHost;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using NSubstitute;
using Relativa.Graph.Graph;
using StackExchange.Redis;
using Xunit;

namespace Relativa.Graph.Integration.Tests;

/// <summary>Lab 4: Cache-Aside behaviour of GET /api/v1/graph (X-Cache header) and of RedisGraphCacheService.</summary>
public sealed class GraphCacheTests : IClassFixture<GraphApiFactory>
{
    private readonly GraphApiFactory _factory;

    public GraphCacheTests(GraphApiFactory factory) => _factory = factory;

    private sealed class DictionaryGraphCache(bool available) : IGraphCacheService
    {
        private readonly ConcurrentDictionary<string, GraphResponseDto> _store = new();
        public int InvalidateCalls { get; private set; }

        public Task<GraphCacheLookup> GetAsync(int userId, int organizationId, string? riskLevel, CancellationToken ct)
        {
            if (!available) return Task.FromResult(GraphCacheLookup.Unavailable);
            return Task.FromResult(_store.TryGetValue($"{userId}:{organizationId}:{riskLevel}", out var v)
                ? GraphCacheLookup.Hit(v)
                : GraphCacheLookup.Miss);
        }

        public Task SetAsync(int userId, int organizationId, string? riskLevel, GraphResponseDto value, CancellationToken ct)
        {
            _store[$"{userId}:{organizationId}:{riskLevel}"] = value;
            return Task.CompletedTask;
        }

        public Task InvalidateForOrgAsync(int organizationId, CancellationToken ct)
        {
            InvalidateCalls++;
            _store.Clear();
            return Task.CompletedTask;
        }
    }

    private HttpClient ClientWith(IGraphCacheService cache) =>
        _factory.WithWebHostBuilder(b => b.ConfigureTestServices(s =>
        {
            s.RemoveAll<IGraphCacheService>();
            s.AddSingleton(cache);
        })).CreateClient();

    private async Task<string?> GetXCache(HttpClient client)
    {
        var request = new HttpRequestMessage(HttpMethod.Get, $"/api/v1/graph?organizationId={_factory.OrgId}");
        request.Headers.Add("X-User-Id", _factory.OrgAdminUserId.ToString());
        var response = await client.SendAsync(request);
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        return response.Headers.TryGetValues("X-Cache", out var v) ? v.Single() : null;
    }

    [Fact]
    public async Task GetGraph_FirstRequestMiss_SecondRequestHit()
    {
        var client = ClientWith(new DictionaryGraphCache(available: true));

        (await GetXCache(client)).Should().Be("MISS");
        (await GetXCache(client)).Should().Be("HIT");
    }

    [Fact]
    public async Task GetGraph_AfterInvalidation_NextRequestIsMiss()
    {
        var cache = new DictionaryGraphCache(available: true);
        var client = ClientWith(cache);
        await GetXCache(client);
        (await GetXCache(client)).Should().Be("HIT");

        await cache.InvalidateForOrgAsync(_factory.OrgId, CancellationToken.None);

        (await GetXCache(client)).Should().Be("MISS");
    }

    [Fact]
    public async Task GetGraph_CacheUnavailable_StillServesFromDatabaseWithBypass()
    {
        var client = ClientWith(new DictionaryGraphCache(available: false));

        (await GetXCache(client)).Should().Be("BYPASS");
        (await GetXCache(client)).Should().Be("BYPASS");
    }

    private static RedisGraphCacheService NewRedisService(IDistributedCache cache, IConnectionMultiplexer redis) =>
        new(cache, redis, new ConfigurationBuilder().Build(), NullLogger<RedisGraphCacheService>.Instance);

    [Fact]
    public async Task RedisService_SetThenGet_RoundTripsTheGraph()
    {
        var cache = new MemoryDistributedCache(Options.Create(new MemoryDistributedCacheOptions()));
        var service = NewRedisService(cache, Substitute.For<IConnectionMultiplexer>());
        var graph = new GraphResponseDto(
            [new GraphNodeDto("user:1", "user_self", "A B", null, null, 1, "user", null, ["view"])],
            [new GraphEdgeDto("e1", "user:1", "workspace:1", "user_workspace", null)]);

        await service.SetAsync(1, 7, null, graph, CancellationToken.None);
        var hit = await service.GetAsync(1, 7, null, CancellationToken.None);
        var otherOrg = await service.GetAsync(1, 8, null, CancellationToken.None);
        var otherRisk = await service.GetAsync(1, 7, "high", CancellationToken.None);

        hit.Available.Should().BeTrue();
        hit.Value!.Nodes.Should().ContainSingle().Which.Id.Should().Be("user:1");
        hit.Value.Edges.Should().ContainSingle();
        otherOrg.Value.Should().BeNull("another organization has its own key");
        otherRisk.Value.Should().BeNull("the risk filter is part of the key");
    }

    [Fact]
    public async Task RedisService_WhenRedisFails_ReportsUnavailableAndNeverThrows()
    {
        var broken = Substitute.For<IDistributedCache>();
        broken.GetAsync(Arg.Any<string>(), Arg.Any<CancellationToken>())
            .Returns<Task<byte[]?>>(_ => throw new RedisConnectionException(ConnectionFailureType.UnableToConnect, "down"));
        broken.SetAsync(Arg.Any<string>(), Arg.Any<byte[]>(), Arg.Any<DistributedCacheEntryOptions>(), Arg.Any<CancellationToken>())
            .Returns<Task>(_ => throw new RedisConnectionException(ConnectionFailureType.UnableToConnect, "down"));
        var redis = Substitute.For<IConnectionMultiplexer>();
        redis.GetEndPoints(Arg.Any<bool>()).Returns(_ => throw new RedisConnectionException(ConnectionFailureType.UnableToConnect, "down"));
        var service = NewRedisService(broken, redis);

        var lookup = await service.GetAsync(1, 1, null, CancellationToken.None);
        var set = () => service.SetAsync(1, 1, null, new GraphResponseDto([], []), CancellationToken.None);
        var invalidate = () => service.InvalidateForOrgAsync(1, CancellationToken.None);

        lookup.Available.Should().BeFalse();
        await set.Should().NotThrowAsync();
        await invalidate.Should().NotThrowAsync();
    }

    [Fact]
    public void RedisService_KeyAndPattern_FollowTheDocumentedSchema()
    {
        RedisGraphCacheService.CacheKey(5, 3, null).Should().Be("graph:v1:5:3:all");
        RedisGraphCacheService.CacheKey(5, 3, "high").Should().Be("graph:v1:5:3:high");
        RedisGraphCacheService.OrgPattern(3).Should().Be("relativa-graph:graph:v1:*:3:*");
    }
}
