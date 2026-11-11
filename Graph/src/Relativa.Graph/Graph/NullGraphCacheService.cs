namespace Relativa.Graph.Graph;

/// <summary>
/// Used when Redis is not configured (host run without Docker, integration tests): every request is a miss
/// and nothing is stored, so behaviour is identical to the code before Lab 4.
/// </summary>
public sealed class NullGraphCacheService : IGraphCacheService
{
    public Task<GraphCacheLookup> GetAsync(int userId, int organizationId, string? riskLevel, CancellationToken ct)
        => Task.FromResult(GraphCacheLookup.Miss);

    public Task SetAsync(int userId, int organizationId, string? riskLevel, GraphResponseDto value, CancellationToken ct)
        => Task.CompletedTask;

    public Task InvalidateForOrgAsync(int organizationId, CancellationToken ct)
        => Task.CompletedTask;
}
