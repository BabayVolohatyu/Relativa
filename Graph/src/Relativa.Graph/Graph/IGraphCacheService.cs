namespace Relativa.Graph.Graph;

/// <summary>
/// Result of a cache lookup. <see cref="Available"/> = false means the cache layer itself failed (Redis down or slow),
/// which is different from a plain miss: the caller must go to the database and must NOT try to write the result back.
/// </summary>
public readonly record struct GraphCacheLookup(GraphResponseDto? Value, bool Available)
{
    public static GraphCacheLookup Hit(GraphResponseDto value) => new(value, true);
    public static GraphCacheLookup Miss { get; } = new(null, true);
    public static GraphCacheLookup Unavailable { get; } = new(null, false);
}

/// <summary>
/// Lab 4: Cache-Aside storage for <c>GET /api/v1/graph</c>. Implementations must never throw:
/// a failing cache has to degrade to "no cache", not to a failing request.
/// </summary>
public interface IGraphCacheService
{
    Task<GraphCacheLookup> GetAsync(int userId, int organizationId, string? riskLevel, CancellationToken ct);

    Task SetAsync(int userId, int organizationId, string? riskLevel, GraphResponseDto value, CancellationToken ct);

    /// <summary>Removes every cached graph of the organization (all users, all risk levels).</summary>
    Task InvalidateForOrgAsync(int organizationId, CancellationToken ct);
}
