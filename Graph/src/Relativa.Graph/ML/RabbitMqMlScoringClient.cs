using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;
using Relativa.Graph.Messaging;
using Relativa.Persistence.Contracts;

namespace Relativa.Graph.ML;

public sealed class RabbitMqMlScoringClient(
    IOptions<RabbitMqGraphConsumerOptions> opts,
    ILogger<RabbitMqMlScoringClient> logger,
    IOptions<MlScoringResilienceOptions> resilience) : IMlScoringClient
{
    private static readonly JsonSerializerOptions Json = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        PropertyNameCaseInsensitive = true,
    };

    public Task<IReadOnlyDictionary<int, MlScoreDto>> ScoreBatchAsync(
        IReadOnlyList<int> dealEntityIds,
        CancellationToken ct = default)
    {
        if (dealEntityIds.Count == 0)
            return Task.FromResult<IReadOnlyDictionary<int, MlScoreDto>>(new Dictionary<int, MlScoreDto>());

        return SendRpcAsync(dealEntityIds, ct);
    }

    private async Task<IReadOnlyDictionary<int, MlScoreDto>> SendRpcAsync(
        IReadOnlyList<int> dealEntityIds,
        CancellationToken ct)
    {
        var o = opts.Value;
        var timeoutMs = AttemptTimeoutMs();
        var factory = new ConnectionFactory
        {
            HostName = o.Host,
            Port = o.Port,
            UserName = o.Username,
            Password = o.Password,
            RequestedConnectionTimeout = TimeSpan.FromMilliseconds(timeoutMs),
        };

        await using var connection = await factory.CreateConnectionAsync(ct);
        await using var channel = await connection.CreateChannelAsync(cancellationToken: ct);

        await channel.ExchangeDeclareAsync(
            exchange: MlScoringRouting.ExchangeName,
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

        var request = new MlScoreRpcRequestV1(dealEntityIds);
        var body = Encoding.UTF8.GetBytes(JsonSerializer.Serialize(request, Json));

        await channel.BasicPublishAsync(
            exchange: MlScoringRouting.ExchangeName,
            routingKey: MlScoringRouting.CommandRoutingKey,
            mandatory: false,
            basicProperties: props,
            body: body,
            cancellationToken: ct);

        var deadline = DateTime.UtcNow.AddMilliseconds(timeoutMs);
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
            var reply = JsonSerializer.Deserialize<MlScoreRpcReplyV1>(replyJson, Json);
            if (reply is null || reply.ErrorMessage is not null)
            {
                var reason = reply?.ErrorMessage ?? "null reply";
                logger.LogWarning("ML scoring RPC returned error: {Error}", reason);
                throw new MlScoringFailedException(reason);
            }

            return reply.Scores.ToDictionary(
                s => s.EntityId,
                s => new MlScoreDto(s.EntityId, s.ClosureScore, s.ChurnScore, s.UnavailableReason));
        }

        logger.LogWarning("ML scoring RPC timed out after {TimeoutMs}ms", timeoutMs);
        throw new TimeoutException($"Timed out waiting for ML scoring RPC reply after {timeoutMs}ms.");
    }

    private int AttemptTimeoutMs()
    {
        var settings = resilience.Value;
        var configured = settings.Enabled ? settings.PerAttemptTimeoutMs : settings.UnprotectedTimeoutMs;
        return Math.Max(1, configured);
    }
}
