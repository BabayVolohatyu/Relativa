namespace Relativa.Authentication.Application.Options;

public sealed class ConsentOptions
{
    public const string SectionKey = "Consent";

    public string MarketingPolicyVersion { get; set; } = "2026-10-01";

    public string AnalyticsPolicyVersion { get; set; } = "2026-10-01";

    public string? RequiredVersion(string purpose) => purpose switch
    {
        Privacy.ConsentPurpose.MarketingEmail => MarketingPolicyVersion,
        Privacy.ConsentPurpose.OptionalAnalytics => AnalyticsPolicyVersion,
        _ => null
    };
}
