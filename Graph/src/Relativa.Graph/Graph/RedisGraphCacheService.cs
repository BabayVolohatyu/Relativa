using System.Text.Json;
using Microsoft.Extensions.Caching.Distributed;
using StackExchange.Redis;

namespace Relativa.Graph.Graph;

/// <summary>
/// Lab 4: Cache-Aside for the graph response in Redis.
///
/// Key (Redis):   relativa-graph:graph:v1:{userId}:{orgId}:{riskLevel|all}
///                ("relativa-graph:" is the IDistributedCache InstanceName prefix, see Program.cs)
/// Value:         the GraphResponseDto as JSON
/// TTL:           GraphCache:TtlSeconds (default 60) +/- 10% jitter, so keys written together do not expire together
/// Invalidation:  SCAN for relativa-graph:graph:v1:*:{orgId}:* and DEL (all users of the organization)
/// Failure mode:  every Redis call is caught; the caller sees "unavailable" and works from PostgreSQL.
/// </summary>
public sealed class RedisGraphCacheService : IGraphCacheService
{
    public const string InstancePrefix = "relativa-graph:";
    private const string KeyPrefix = "graph:v1:";
    private const int DefaultTtlSeconds = 60;

    private readonly IDistributedCache _cache;
    private readonly IConnectionMultiplexer _redis;
    private readonly ILogger<RedisGraphCacheService> _logger;
    private readonly int _ttlSeconds;

    public RedisGraphCacheService(
        IDistributedCache cache,
        IConnectionMultiplexer redis,
        IConfiguration configuration,
        ILogger<RedisGraphCacheService> logger)
    {
        _cache = cache;
        _redis = redis;
        _logger = logger;
        _ttlSeconds = configuration.GetValue("GraphCache:TtlSeconds", DefaultTtlSeconds);
    }

    // riskLevel reaches this point only after the endpoint validated it (high|medium|low, case-insensitive).
    // It is NOT lower-cased: GraphDataService treats "HIGH" differently from "high", so they must be different keys.
    public static string CacheKey(int userId, int organizationId, string? riskLevel)
        => $"{KeyPrefix}{userId}:{organizationId}:{riskLevel ?? "all"}";

    public static string OrgPattern(int organizationId)
        => $"{InstancePrefix}{KeyPrefix}*:{organizationId}:*";

    public async Task<GraphCacheLookup> GetAsync(int userId, int organizationId, string? riskLevel, CancellationToken ct)
    {
        try
        {
            var bytes = await _cache.GetAsync(CacheKey(userId, organizationId, riskLevel), ct);
            return Deserialize(bytes);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Graph cache read failed (org {OrgId}); falling back to the database.", organizationId);
            return GraphCacheLookup.Unavailable;
        }
    }

    public async Task SetAsync(int userId, int organizationId, string? riskLevel, GraphResponseDto value, CancellationToken ct)
    {
        try
        {
            var options = new DistributedCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromSeconds(JitteredTtlSeconds()),
            };
            var bytes = JsonSerializer.SerializeToUtf8Bytes(value);
            await _cache.SetAsync(CacheKey(userId, organizationId, riskLevel), bytes, options, ct);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Graph cache write failed (org {OrgId}); continuing without cache.", organizationId);
        }
    }

    public async Task InvalidateForOrgAsync(int organizationId, CancellationToken ct)
    {
        try
        {
            var keys = await FindKeysAsync(OrgPattern(organizationId), ct);
            if (keys.Count > 0)
                await _redis.GetDatabase().KeyDeleteAsync(keys.ToArray());

            _logger.LogInformation("Graph cache invalidated for org {OrgId}: {Count} key(s) removed.", organizationId, keys.Count);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Graph cache invalidation failed (org {OrgId}); entries expire by TTL.", organizationId);
        }
    }

    private static GraphCacheLookup Deserialize(byte[]? bytes)
    {
        if (bytes is null)
            return GraphCacheLookup.Miss;

        var value = JsonSerializer.Deserialize<GraphResponseDto>(bytes);
        return value is null ? GraphCacheLookup.Miss : GraphCacheLookup.Hit(value);
    }

    private int JitteredTtlSeconds()
    {
        var jitter = Math.Max(1, _ttlSeconds / 10);
        return Math.Max(1, _ttlSeconds + Random.Shared.Next(-jitter, jitter + 1));
    }

    private async Task<List<RedisKey>> FindKeysAsync(string pattern, CancellationToken ct)
    {
        var keys = new List<RedisKey>();
        foreach (var endpoint in _redis.GetEndPoints())
        {
            var server = _redis.GetServer(endpoint);
            if (server.IsReplica)
                continue;

            await foreach (var key in server.KeysAsync(pattern: pattern).WithCancellation(ct))
                keys.Add(key);
        }
        return keys;
    }
}
