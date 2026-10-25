namespace Relativa.Authentication.Application.Privacy;

public static class ConsentPurpose
{
    public const string MarketingEmail = "MARKETING_EMAIL";
    public const string OptionalAnalytics = "OPTIONAL_ANALYTICS";

    public static bool IsKnown(string? purpose) =>
        purpose is MarketingEmail or OptionalAnalytics;
}

public static class ConsentSource
{
    public const string SettingsUi = "settings-ui";
    public const string Import = "import";

    public static bool IsKnown(string? source) =>
        source is SettingsUi or Import;
}

public static class ConsentStatus
{
    public const string Granted = "granted";
    public const string Withdrawn = "withdrawn";
}

public static class LabPrivacyUsers
{
    public const int SubjectId = 91001;
    public const int OtherId = 91002;
    public const string SubjectEmail = "ada.lovelace@example.test";
    public const string OtherEmail = "grace.hopper@example.test";
    public const string Phone = "+15555550123";
    public const string Password = "synthetic-password-not-real";
    public const string Token = "synthetic-token-not-real";
    public const string PolicyVersion = "2026-10-01";
}
