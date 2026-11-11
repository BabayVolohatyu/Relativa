using System.Net;
using System.Text;
using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;
using Relativa.Graph.Data;
using Relativa.Graph.Graph;
using Relativa.Graph.Messaging;
using Relativa.Persistence.Contracts;

namespace Relativa.Graph;

public static class EntityGraphEndpoints
{
    private static readonly JsonSerializerOptions Json = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        PropertyNameCaseInsensitive = true,
    };

    public static void MapEntityGraphEndpoints(WebApplication app)
    {
        var group = app.MapGroup("/api/v1/workspaces/{workspaceId:int}/entity-graph")
            .WithTags("EntityGraph");

        group.MapPost("/create", async (
                int workspaceId,
                HttpContext httpContext,
                JsonElement createBody,
                IOptions<RabbitMqGraphConsumerOptions> mq,
                GraphQueryDbContext db,
                IGraphCacheService graphCache,
                CancellationToken ct) =>
            {
                int userId;
                try
                {
                    userId = GetUserIdOrThrow(httpContext);
                }
                catch (UnauthorizedAccessException)
                {
                    return Results.Unauthorized();
                }

                var cmd = new EntityGraphCreateRpcV1(workspaceId, userId, createBody.GetRawText());
                try
                {
                    var reply = await RpcCreateAsync(mq.Value, cmd, ct);
                    if (!reply.Success || string.IsNullOrEmpty(reply.EntityDetailJson))
                        return Results.BadRequest(reply.ErrorMessage ?? "Graph create failed.");

                    // Lab 4: the write succeeded, so every cached graph of this organization is stale. Drop it
                    // BEFORE answering, so the client's next GET /api/v1/graph is a guaranteed MISS with fresh data.
                    await InvalidateGraphCacheAsync(db, graphCache, workspaceId, ct);
                    return Results.Content(reply.EntityDetailJson, "application/json", statusCode: StatusCodes.Status200OK);
                }
                catch (TimeoutException)
                {
                    return Results.StatusCode((int)HttpStatusCode.GatewayTimeout);
                }
            })
            .WithName("EntityGraphCreate")
            .WithSummary("Delegates entity creation to Core via RabbitMQ RPC (single-node create body matches Core CreateEntityRequest).");
    }

    /// <summary>
    /// Best effort: resolves the workspace's organization and clears its cached graphs.
    /// A failure here must not fail the create (the entity already exists); the cache entries then expire by TTL.
    /// </summary>
    private static async Task InvalidateGraphCacheAsync(
        GraphQueryDbContext db, IGraphCacheService graphCache, int workspaceId, CancellationToken ct)
    {
        try
        {
            var organizationId = await db.Workspaces
                .Where(w => w.Id == workspaceId)
                .Select(w => (int?)w.OrganizationId)
                .FirstOrDefaultAsync(ct);

            if (organizationId is { } orgId)
                await graphCache.InvalidateForOrgAsync(orgId, ct);
        }
        catch (Exception) when (!ct.IsCancellationRequested)
        {
            // Cache is optional; the cache service logs its own failures, a failing lookup is covered by the TTL.
        }
    }

    private static int GetUserIdOrThrow(HttpContext ctx)
    {
        var v = ctx.Request.Headers["X-User-Id"].ToString();
        if (string.IsNullOrEmpty(v) || !int.TryParse(v, out var id))
            throw new UnauthorizedAccessException("Missing or invalid X-User-Id header.");
        return id;
    }

    private static async Task<EntityGraphCreateRpcReplyV1> RpcCreateAsync(
        RabbitMqGraphConsumerOptions opts,
        EntityGraphCreateRpcV1 cmd,
        CancellationToken ct)
    {
        var factory = new ConnectionFactory
        {
            HostName = opts.Host,
            Port = opts.Port,
            UserName = opts.Username,
            Password = opts.Password,
        };

        await using var connection = await factory.CreateConnectionAsync(ct);
        await using var channel = await connection.CreateChannelAsync(cancellationToken: ct);

        await channel.ExchangeDeclareAsync(
            exchange: EntityGraphRouting.ExchangeName,
            type: ExchangeType.Topic,
            durable: true,
            autoDelete: false,
            cancellationToken: ct);

        var declareOk = await channel.QueueDeclareAsync(
            queue: string.Empty,
            durable: false,
            exclusive: true,
            autoDelete: true,
            arguments: null,
            passive: false,
            cancellationToken: ct);

        var replyQueue = declareOk.QueueName;
        var correlationId = Guid.NewGuid().ToString("N");
        var props = new BasicProperties
        {
            CorrelationId = correlationId,
            ReplyTo = replyQueue,
        };

        var body = Encoding.UTF8.GetBytes(JsonSerializer.Serialize(cmd, Json));
        await channel.BasicPublishAsync(
            exchange: EntityGraphRouting.ExchangeName,
            routingKey: EntityGraphRouting.CommandRoutingKey,
            mandatory: false,
            basicProperties: props,
            body: body,
            cancellationToken: ct);

        var deadline = DateTime.UtcNow.AddSeconds(30);
        while (DateTime.UtcNow < deadline)
        {
            ct.ThrowIfCancellationRequested();
            var get = await channel.BasicGetAsync(replyQueue, autoAck: true, cancellationToken: ct);
            if (get is null)
            {
                await Task.Delay(25, ct);
                continue;
            }

            if (get.BasicProperties?.CorrelationId != correlationId)
                continue;

            var replyJson = Encoding.UTF8.GetString(get.Body.ToArray());
            var reply = JsonSerializer.Deserialize<EntityGraphCreateRpcReplyV1>(replyJson, Json);
            return reply ?? new EntityGraphCreateRpcReplyV1(false, "Invalid reply payload.", null);
        }

        throw new TimeoutException("Timed out waiting for Core entity graph reply.");
    }
}
