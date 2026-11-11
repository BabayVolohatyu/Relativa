namespace Relativa.Graph.Graph;

public static class GraphQueryEndpoints
{
    private static readonly HashSet<string> ValidRiskLevels =
        new(StringComparer.OrdinalIgnoreCase) { "high", "medium", "low" };

    public const string CacheHeader = "X-Cache";

    public static void MapGraphQueryEndpoints(WebApplication app)
    {
        app.MapGet("/api/v1/graph", GetGraphAsync)
            .WithTags("Graph")
            .WithName("GetGraph")
            .WithSummary("Returns graph nodes and edges for the authenticated user within the specified organization. " +
                         "Cache-Aside through Redis; the X-Cache response header is HIT, MISS or BYPASS (cache unavailable).");
    }

    private static async Task<IResult> GetGraphAsync(
        int organizationId,
        string? riskLevel,
        HttpContext ctx,
        IGraphDataService svc,
        IGraphCacheService cache,
        CancellationToken ct)
    {
        int userId;
        try
        {
            userId = GetUserIdOrThrow(ctx);
        }
        catch (UnauthorizedAccessException)
        {
            return Results.Unauthorized();
        }

        if (riskLevel is not null && !ValidRiskLevels.Contains(riskLevel))
            return Results.BadRequest(
                $"Invalid risk_level '{riskLevel}'. Allowed values: high, medium, low.");

        // Cache-Aside. 1) look up  2) HIT: return without touching PostgreSQL / ML  3) MISS: build, store, return.
        var lookup = await cache.GetAsync(userId, organizationId, riskLevel, ct);
        if (lookup.Value is not null)
        {
            ctx.Response.Headers[CacheHeader] = "HIT";
            return Results.Ok(lookup.Value);
        }

        // BYPASS = the cache layer is down: serve from PostgreSQL and do not try to write back.
        ctx.Response.Headers[CacheHeader] = lookup.Available ? "MISS" : "BYPASS";
        var result = await svc.BuildGraphAsync(userId, organizationId, riskLevel, ct);
        if (lookup.Available)
            await cache.SetAsync(userId, organizationId, riskLevel, result, ct);

        return Results.Ok(result);
    }

    private static int GetUserIdOrThrow(HttpContext ctx)
    {
        var v = ctx.Request.Headers["X-User-Id"].ToString();
        if (string.IsNullOrEmpty(v) || !int.TryParse(v, out var id))
            throw new UnauthorizedAccessException("Missing or invalid X-User-Id header.");
        return id;
    }
}
