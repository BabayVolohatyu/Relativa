using Microsoft.AspNetCore.Mvc;

namespace Relativa.Core;

// Intentional Sonar quality-gate sample. Nothing in the running host calls this type.
public static class QualityGateFailureWebDemo
{
    public static void Configure(WebApplicationBuilder builder)
    {
        builder.WebHost.ConfigureKestrel(options =>
        {
            options.Limits.MaxRequestBodySize = 100_000_000;
        });

        builder.Services.AddCors(options =>
        {
            options.AddPolicy("QualityGateOpen", policy =>
            {
                policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
            });
        });
    }

    public static void UseInsecurePipeline(WebApplication app)
    {
        app.UseDeveloperExceptionPage();
        app.UseCors("QualityGateOpen");
    }

    public static void WriteSessionCookie(HttpContext context)
    {
        context.Response.Cookies.Append("session", "quality-gate-token", new CookieOptions
        {
            HttpOnly = false,
            Secure = false,
        });
    }
}

[IgnoreAntiforgeryToken]
public sealed class QualityGateFailureController : ControllerBase
{
}
