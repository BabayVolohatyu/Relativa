using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;

namespace Relativa.Gateway;

public static class OperatorDigestEndpoints
{
    public static void Map(WebApplication app)
    {
        app.MapGet("/api/v1/operator/digest", () => Results.Ok(new
        {
            kind = "operator-digest",
            audience = "sales-operator",
            includes = new[] { "openDeals", "highRiskDeals", "pendingInvitations" }
        })).AllowAnonymous();
    }
}
