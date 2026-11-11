using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Relativa.Graph;
using Relativa.Graph.Dashboard;
using Relativa.Graph.Data;
using Relativa.Graph.Graph;
using Relativa.Graph.Hubs;
using Relativa.Graph.Messaging;
using Relativa.Graph.ML;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddOpenApi();

var graphConnectionString = builder.Configuration.GetConnectionString("Default");
if (string.IsNullOrWhiteSpace(graphConnectionString))
{
    throw new InvalidOperationException("ConnectionStrings:Default must be configured for Graph choreography idempotency.");
}

builder.Services.AddDbContext<GraphDbContext>(opt => opt.UseNpgsql(graphConnectionString));
builder.Services.AddDbContext<GraphQueryDbContext>(opt => opt.UseNpgsql(graphConnectionString));
builder.Services.AddScoped<IGraphDataService, GraphDataService>();
builder.Services.AddScoped<IDashboardService, DashboardService>();
builder.Services.AddScoped<IWorkspaceDashboardService, WorkspaceDashboardService>();

builder.Services.Configure<MlScoringResilienceOptions>(
    builder.Configuration.GetSection(MlScoringResilienceOptions.SectionKey));
builder.Services.AddSingleton<IAsyncDelay, SystemAsyncDelay>();
builder.Services.AddSingleton<RabbitMqMlScoringClient>();
builder.Services.AddSingleton<IMlScoringClient>(sp =>
{
    var raw = sp.GetRequiredService<RabbitMqMlScoringClient>();
    var resilience = sp.GetRequiredService<IOptions<MlScoringResilienceOptions>>();
    if (!resilience.Value.Enabled)
        return raw;

    return new ResilientMlScoringClient(
        raw,
        resilience,
        sp.GetRequiredService<IAsyncDelay>(),
        sp.GetRequiredService<ILogger<ResilientMlScoringClient>>());
});
builder.Services.AddSingleton<IMlRecalculationClient, RabbitMqMlRecalculationClient>();

builder.Services.Configure<RabbitMqGraphConsumerOptions>(
    builder.Configuration.GetSection(RabbitMqGraphConsumerOptions.SectionKey));
builder.Services.AddHostedService<DomainEventConsumerHostedService>();

// ── Lab 2: externalised state ────────────────────────────────────────────────
// Everything that must be shared between Graph instances lives in Redis:
//   * IDistributedCache  → ML-enqueue cooldown keys (WorkspaceDashboardService)
//   * SignalR backplane  → group/broadcast fan-out across instances (GraphHub)
// Redis runs only as a container; docker-compose injects Redis__ConnectionString.
// An empty value (running the service on the host without Docker) falls back to the
// old single-process behaviour and logs a warning - that mode is NOT safe for >1 instance.
var redisConnection = builder.Configuration["Redis:ConnectionString"];
var redisEnabled = !string.IsNullOrWhiteSpace(redisConnection);
if (redisEnabled)
{
    // Lab 4: ONE shared connection for IDistributedCache (ML cooldown + graph cache) and the graph cache's SCAN/DEL.
    var redisMultiplexer = RedisMultiplexerFactory.Create(redisConnection!);
    builder.Services.AddSingleton(redisMultiplexer);
    builder.Services.AddStackExchangeRedisCache(o =>
    {
        o.ConnectionMultiplexerFactory = () => Task.FromResult(redisMultiplexer);
        o.InstanceName = RedisGraphCacheService.InstancePrefix;
    });
    builder.Services.AddSignalR().AddStackExchangeRedis(redisConnection!, o =>
    {
        o.Configuration.ChannelPrefix = StackExchange.Redis.RedisChannel.Literal("relativa-graph");
    });
    // Lab 4: Cache-Aside for GET /api/v1/graph (key, TTL, invalidation: see RedisGraphCacheService).
    builder.Services.AddSingleton<IGraphCacheService, RedisGraphCacheService>();
}
else
{
    builder.Services.AddDistributedMemoryCache();
    builder.Services.AddSignalR();
    builder.Services.AddSingleton<IGraphCacheService, NullGraphCacheService>();
}

// ── Lab 3: readiness probe ───────────────────────────────────────────────────
// GET /health runs a real PostgreSQL connectivity check through EF Core (can the DbContext reach the DB?).
// 200 "Healthy" = ready for traffic, 503 "Unhealthy" = take this instance out of rotation.
builder.Services.AddHealthChecks()
    .AddDbContextCheck<GraphDbContext>("postgres");

builder.Services.AddProblemDetails();
builder.Services.AddExceptionHandler<GraphGlobalExceptionHandler>();

var app = builder.Build();

// Instance identification: lets a client (and the lab demo) see WHICH instance served a request.
// INSTANCE_ID is set per container by docker-compose; the hostname (= container id) is the fallback.
var instanceId = Environment.GetEnvironmentVariable("INSTANCE_ID") ?? Environment.MachineName;
app.Use(async (ctx, next) =>
{
    ctx.Response.OnStarting(() =>
    {
        ctx.Response.Headers["X-Instance-ID"] = instanceId;
        return Task.CompletedTask;
    });
    await next(ctx);
});

// ── Lab 3: synthetic latency for the asymmetric-load experiment ──────────────
// ARTIFICIAL_DELAY_MS > 0 makes THIS instance slow (every request waits that long before being handled),
// which simulates a degraded node. Unset / 0 = no effect (the default in every normal run).
var artificialDelayMs = int.TryParse(Environment.GetEnvironmentVariable("ARTIFICIAL_DELAY_MS"), out var delayMs) ? delayMs : 0;
if (artificialDelayMs > 0)
{
    app.Logger.LogWarning("Graph instance {InstanceId} runs with ARTIFICIAL_DELAY_MS={DelayMs}.", instanceId, artificialDelayMs);
    app.Use(async (ctx, next) =>
    {
        await Task.Delay(artificialDelayMs);
        await next(ctx);
    });
}

if (redisEnabled)
    app.Logger.LogInformation("Graph instance {InstanceId} started with Redis-backed shared state.", instanceId);
else
    app.Logger.LogWarning(
        "Graph instance {InstanceId} started WITHOUT Redis (Redis:ConnectionString is empty): " +
        "cache and SignalR are process-local. Do not run more than one instance in this mode.",
        instanceId);

app.UseExceptionHandler();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.MapGet("/", () => Results.Ok(new { service = "relativa-graph" }));
app.MapHealthChecks("/health");

EntityGraphEndpoints.MapEntityGraphEndpoints(app);
GraphQueryEndpoints.MapGraphQueryEndpoints(app);
DashboardEndpoints.MapDashboardEndpoints(app);
WorkspaceDashboardEndpoints.MapWorkspaceDashboardEndpoints(app);

app.MapHub<GraphHub>("/hubs/graph");

app.Run();

public partial class Program;
