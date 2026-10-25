using System.Security.Claims;
using Relativa.Authentication.Application.Interfaces;
using Relativa.Authentication.Application.Privacy;
using Relativa.Authentication.Middleware;

namespace Relativa.Authentication.Endpoints;

public static class PrivacyEndpoints
{
    public static RouteGroupBuilder MapPrivacyEndpoints(this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/api/v1/auth")
            .WithTags("Privacy")
            .RequireAuthorization();

        group.MapPost("/privacy/log-probe", (
            LogProbeRequest request,
            ILogger<LogProbeRequest> logger,
            HttpContext http) =>
        {
            var correlationId = Correlation(http);
            logger.LogInformation(
                "privacy log probe correlation {CorrelationId} {@Payload}",
                correlationId,
                new
                {
                    request.Email,
                    request.Phone,
                    Nested = new { request.Password, request.Token }
                });

            try
            {
                throw new InvalidOperationException(
                    $"token={request.Token} email={request.Email} phone={request.Phone}");
            }
            catch (Exception ex)
            {
                logger.LogWarning(ex, "privacy log probe rejected correlation {CorrelationId}", correlationId);
            }

            return Results.NoContent();
        })
        .WithName("LogProbe")
        .WithSummary("Write a sanitized diagnostic log for an email, phone, password, and token")
        .WithDescription("Lab subject is user 91001 (ada.lovelace@example.test). Paste only the accessToken into Bearer Token.")
        .Produces(StatusCodes.Status204NoContent);

        group.MapGet("/users/{id:int}/personal-data", async (
            int id,
            IPersonalDataService service,
            ClaimsPrincipal user,
            HttpContext http,
            CancellationToken ct) =>
        {
            var decision = await service.ExportAsync(CurrentUserId(user), id, Correlation(http), ct);
            return decision.Found
                ? Results.Ok(decision.Value)
                : Results.NotFound(NotFoundBody());
        })
        .WithName("ExportPersonalData")
        .WithSummary("Export the authenticated user's personal data")
        .WithDescription("Allowed only for the authenticated subject. User 91001 is the lab subject, not the seeded admin.")
        .Produces<PersonalDataExport>()
        .Produces(StatusCodes.Status404NotFound);

        group.MapPost("/users/{id:int}/anonymize", async (
            int id,
            IAnonymizationService service,
            ClaimsPrincipal user,
            HttpContext http,
            CancellationToken ct) =>
        {
            var decision = await service.AnonymizeAsync(CurrentUserId(user), id, Correlation(http), ct);
            return decision.Found
                ? Results.Ok(decision.Value)
                : Results.NotFound(NotFoundBody());
        })
        .WithName("AnonymizeUser")
        .WithSummary("Irreversibly anonymize the authenticated user's personal data")
        .WithDescription("Do not send this for user 1. The lab subject id is 91001.")
        .Produces<AnonymizeResult>()
        .Produces(StatusCodes.Status404NotFound);

        group.MapPost("/users/{id:int}/consents/{purpose}/grant", async (
            int id,
            string purpose,
            ConsentCommand command,
            IConsentService service,
            ClaimsPrincipal user,
            HttpContext http,
            CancellationToken ct) =>
        {
            var decision = await service.GrantAsync(CurrentUserId(user), id, purpose, command, Correlation(http), ct);
            return decision.Found
                ? Results.Ok(decision.Value)
                : Results.NotFound(NotFoundBody());
        })
        .WithName("GrantConsent")
        .WithSummary("Grant a purpose-specific consent")
        .Produces<ConsentState>()
        .Produces(StatusCodes.Status404NotFound)
        .Produces(StatusCodes.Status400BadRequest);

        group.MapPost("/users/{id:int}/consents/{purpose}/revoke", async (
            int id,
            string purpose,
            IConsentService service,
            ClaimsPrincipal user,
            HttpContext http,
            CancellationToken ct) =>
        {
            var decision = await service.RevokeAsync(CurrentUserId(user), id, purpose, Correlation(http), ct);
            return decision.Found
                ? Results.Ok(decision.Value)
                : Results.NotFound(NotFoundBody());
        })
        .WithName("RevokeConsent")
        .WithSummary("Revoke a purpose-specific consent")
        .Produces<ConsentState>()
        .Produces(StatusCodes.Status404NotFound);

        group.MapPost("/users/{id:int}/marketing-email", async (
            int id,
            MarketingPurposeRequest request,
            IMarketingEmailService service,
            ClaimsPrincipal user,
            HttpContext http,
            CancellationToken ct) =>
        {
            var decision = await service.SendAsync(CurrentUserId(user), id, request.Purpose, Correlation(http), ct);
            return decision.Found
                ? Results.Ok(decision.Value)
                : Results.NotFound(NotFoundBody());
        })
        .WithName("SendMarketingEmail")
        .WithSummary("Send a marketing message when the matching consent is granted")
        .Produces<MarketingSendResult>()
        .Produces(StatusCodes.Status403Forbidden)
        .Produces(StatusCodes.Status404NotFound);

        return group;
    }

    private static int CurrentUserId(ClaimsPrincipal user)
    {
        var sub = user.FindFirstValue("sub")
            ?? throw new UnauthorizedAccessException("Missing sub claim.");
        return int.Parse(sub);
    }

    private static string Correlation(HttpContext http) =>
        http.Items[CorrelationIdMiddleware.ItemKey] as string ?? Guid.NewGuid().ToString("D");

    private static object NotFoundBody() => new
    {
        status = StatusCodes.Status404NotFound,
        title = "Not Found",
        detail = "Resource not found."
    };
}

public sealed record LogProbeRequest(string Email, string Phone, string Password, string Token);

public sealed record MarketingPurposeRequest(string Purpose);
