using Microsoft.Extensions.Options;

namespace Relativa.Graph.ML;

public sealed class ResilientMlScoringClient(
    IMlScoringClient inner,
    IOptions<MlScoringResilienceOptions> options,
    IAsyncDelay delay,
    ILogger<ResilientMlScoringClient> logger) : IMlScoringClient
{
    public async Task<IReadOnlyDictionary<int, MlScoreDto>> ScoreBatchAsync(
        IReadOnlyList<int> dealEntityIds,
        CancellationToken ct = default)
    {
        if (dealEntityIds.Count == 0)
            return new Dictionary<int, MlScoreDto>();

        var settings = options.Value;
        var maxAttempts = Math.Max(1, settings.MaxAttempts);
        Exception? last = null;

        for (var attemptNumber = 1; attemptNumber <= maxAttempts; attemptNumber++)
        {
            ct.ThrowIfCancellationRequested();
            try
            {
                using var attemptCts = CancellationTokenSource.CreateLinkedTokenSource(ct);
                var timeout = TimeSpan.FromMilliseconds(Math.Max(1, settings.PerAttemptTimeoutMs));
                attemptCts.CancelAfter(timeout);
                var attempt = inner.ScoreBatchAsync(dealEntityIds, attemptCts.Token);
                var budget = Task.Delay(timeout, ct);
                var finished = await Task.WhenAny(attempt, budget);
                if (finished != attempt)
                {
                    attemptCts.Cancel();
                    ObserveFault(attempt);
                    if (ct.IsCancellationRequested)
                        throw new OperationCanceledException(ct);
                    throw new TimeoutException(
                        $"ML scoring attempt exceeded {timeout.TotalMilliseconds:0}ms.");
                }

                return await attempt;
            }
            catch (OperationCanceledException) when (ct.IsCancellationRequested)
            {
                throw;
            }
            catch (Exception ex)
            {
                last = ex;
            }

            if (attemptNumber < maxAttempts)
                await delay.DelayAsync(BackoffAfter(attemptNumber, settings), ct);
        }

        logger.LogWarning(
            last,
            "ml_scoring_degraded attempts={Attempts} reason={Reason}",
            maxAttempts,
            last?.Message ?? "unknown");

        return new Dictionary<int, MlScoreDto>();
    }

    private static void ObserveFault(Task attempt)
    {
        _ = attempt.ContinueWith(
            t => { _ = t.Exception; },
            CancellationToken.None,
            TaskContinuationOptions.OnlyOnFaulted | TaskContinuationOptions.ExecuteSynchronously,
            TaskScheduler.Default);
    }

    internal static TimeSpan BackoffAfter(int failedAttempt, MlScoringResilienceOptions settings)
    {
        var shift = Math.Min(failedAttempt - 1, 16);
        var multiplier = 1 << shift;
        var delayMs = Math.Min(settings.MaxDelayMs, settings.BaseDelayMs * multiplier);
        return TimeSpan.FromMilliseconds(Math.Max(0, delayMs));
    }
}
