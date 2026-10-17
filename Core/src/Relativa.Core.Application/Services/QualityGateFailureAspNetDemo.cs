using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;

namespace Relativa.Core.Application.Services;

// Intentional Sonar quality-gate sample. Nothing calls this type.
public static class QualityGateFailureAspNetDemo
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
