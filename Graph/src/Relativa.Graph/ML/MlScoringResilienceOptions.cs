namespace Relativa.Graph.ML;

public sealed class MlScoringResilienceOptions
{
    public const string SectionKey = "MlScoringResilience";

    /// <summary>
    /// When false, the raw RPC client is used directly: one attempt, then the exception propagates.
    /// </summary>
    public bool Enabled { get; set; } = true;

    public int MaxAttempts { get; set; } = 3;

    public int PerAttemptTimeoutMs { get; set; } = 200;

    public int BaseDelayMs { get; set; } = 50;

    public int MaxDelayMs { get; set; } = 400;

    /// <summary>
    /// Single-attempt deadline used only when <see cref="Enabled"/> is false.
    /// </summary>
    public int UnprotectedTimeoutMs { get; set; } = 2000;
}
