using FluentAssertions;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using NSubstitute;
using Relativa.Graph.ML;
using Xunit;

namespace Relativa.Graph.Integration.Tests;

public sealed class ResilientMlScoringClientTests
{
    private sealed class RecordingDelay : IAsyncDelay
    {
        public List<TimeSpan> Delays { get; } = [];

        public Task DelayAsync(TimeSpan delay, CancellationToken ct)
        {
            ct.ThrowIfCancellationRequested();
            Delays.Add(delay);
            return Task.CompletedTask;
        }
    }

    private sealed class ListLogger : ILogger<ResilientMlScoringClient>
    {
        public List<string> Messages { get; } = [];

        public IDisposable? BeginScope<TState>(TState state) where TState : notnull => null;

        public bool IsEnabled(LogLevel logLevel) => true;

        public void Log<TState>(
            LogLevel logLevel,
            EventId eventId,
            TState state,
            Exception? exception,
            Func<TState, Exception?, string> formatter)
        {
            Messages.Add(formatter(state, exception));
        }
    }

    private static MlScoringResilienceOptions Settings() => new()
    {
        Enabled = true,
        MaxAttempts = 3,
        PerAttemptTimeoutMs = 200,
        BaseDelayMs = 50,
        MaxDelayMs = 400,
        UnprotectedTimeoutMs = 2000,
    };

    private static ResilientMlScoringClient Build(
        IMlScoringClient inner,
        RecordingDelay delay,
        ListLogger logger) =>
        new(inner, Options.Create(Settings()), delay, logger);

    [Fact]
    public async Task ScoreBatchAsync_Success_CallsOnceAndDoesNotDegrade()
    {
        var inner = Substitute.For<IMlScoringClient>();
        var scores = new Dictionary<int, MlScoreDto> { [7] = new(7, 0.9, 0.1, null) };
        inner.ScoreBatchAsync(Arg.Any<IReadOnlyList<int>>(), Arg.Any<CancellationToken>())
            .Returns(scores);
        var delay = new RecordingDelay();
        var logger = new ListLogger();

        var result = await Build(inner, delay, logger).ScoreBatchAsync([7]);

        result.Should().ContainKey(7);
        result[7].ClosureScore.Should().Be(0.9);
        await inner.Received(1).ScoreBatchAsync(Arg.Any<IReadOnlyList<int>>(), Arg.Any<CancellationToken>());
        delay.Delays.Should().BeEmpty();
        logger.Messages.Should().NotContain(m => m.Contains("ml_scoring_degraded", StringComparison.Ordinal));
    }

    [Fact]
    public async Task ScoreBatchAsync_TwoTimeoutsThenSuccess_RetriesWithBackoff()
    {
        var inner = Substitute.For<IMlScoringClient>();
        var calls = 0;
        inner.ScoreBatchAsync(Arg.Any<IReadOnlyList<int>>(), Arg.Any<CancellationToken>())
            .Returns(_ =>
            {
                calls++;
                if (calls < 3)
                    return Task.FromException<IReadOnlyDictionary<int, MlScoreDto>>(new TimeoutException("slow"));
                IReadOnlyDictionary<int, MlScoreDto> ok = new Dictionary<int, MlScoreDto>
                {
                    [4] = new(4, 0.4, 0.2, null),
                };
                return Task.FromResult(ok);
            });
        var delay = new RecordingDelay();
        var logger = new ListLogger();

        var result = await Build(inner, delay, logger).ScoreBatchAsync([4]);

        result[4].ClosureScore.Should().Be(0.4);
        calls.Should().Be(3);
        delay.Delays.Should().Equal(TimeSpan.FromMilliseconds(50), TimeSpan.FromMilliseconds(100));
        logger.Messages.Should().NotContain(m => m.Contains("ml_scoring_degraded", StringComparison.Ordinal));
    }

    [Fact]
    public async Task ScoreBatchAsync_AllAttemptsFail_ReturnsEmptyAndLogsDegradation()
    {
        var inner = Substitute.For<IMlScoringClient>();
        inner.ScoreBatchAsync(Arg.Any<IReadOnlyList<int>>(), Arg.Any<CancellationToken>())
            .Returns<IReadOnlyDictionary<int, MlScoreDto>>(_ => throw new TimeoutException("down"));
        var delay = new RecordingDelay();
        var logger = new ListLogger();

        var result = await Build(inner, delay, logger).ScoreBatchAsync([1, 2]);

        result.Should().BeEmpty();
        await inner.Received(3).ScoreBatchAsync(Arg.Any<IReadOnlyList<int>>(), Arg.Any<CancellationToken>());
        delay.Delays.Should().HaveCount(2);
        logger.Messages.Should().Contain(m => m.Contains("ml_scoring_degraded", StringComparison.Ordinal)
                                              && m.Contains("attempts=3", StringComparison.Ordinal));
    }

    [Fact]
    public async Task ScoreBatchAsync_CallerCancelled_DoesNotRetry()
    {
        var inner = Substitute.For<IMlScoringClient>();
        var calls = 0;
        using var cts = new CancellationTokenSource();
        inner.ScoreBatchAsync(Arg.Any<IReadOnlyList<int>>(), Arg.Any<CancellationToken>())
            .Returns(_ =>
            {
                calls++;
                cts.Cancel();
                return Task.FromException<IReadOnlyDictionary<int, MlScoreDto>>(
                    new OperationCanceledException(cts.Token));
            });
        var delay = new RecordingDelay();
        var logger = new ListLogger();

        var act = () => Build(inner, delay, logger).ScoreBatchAsync([1], cts.Token);

        await act.Should().ThrowAsync<OperationCanceledException>();
        calls.Should().Be(1);
        delay.Delays.Should().BeEmpty();
        logger.Messages.Should().NotContain(m => m.Contains("ml_scoring_degraded", StringComparison.Ordinal));
    }
}
