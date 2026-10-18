namespace Relativa.Graph.ML;

public interface IAsyncDelay
{
    Task DelayAsync(TimeSpan delay, CancellationToken ct);
}

public sealed class SystemAsyncDelay : IAsyncDelay
{
    public Task DelayAsync(TimeSpan delay, CancellationToken ct) => Task.Delay(delay, ct);
}
