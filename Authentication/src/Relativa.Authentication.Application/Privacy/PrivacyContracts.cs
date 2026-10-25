namespace Relativa.Authentication.Application.Privacy;

public sealed record PrivacyDecision<T>(bool Found, T? Value)
{
    public static PrivacyDecision<T> Missing() => new(false, default);

    public static PrivacyDecision<T> Ok(T value) => new(true, value);
}

public sealed record PersonalDataExport(
    int SchemaVersion,
    ExportMeta Meta,
    ExportProfile Profile,
    ExportSettings Settings,
    IReadOnlyList<ExportEmail> Emails,
    IReadOnlyList<ExportExternalLogin> ExternalLogins,
    IReadOnlyList<ExportActivity> Activity,
    IReadOnlyList<ExportConsent> Consents,
    IReadOnlyList<string> Excluded);

public sealed record ExportMeta(int SchemaVersion, DateTimeOffset GeneratedAt, int SubjectId, string CorrelationId);

public sealed record ExportProfile(
    int Id,
    string FirstName,
    string LastName,
    string Email,
    string? Phone,
    DateOnly? DateOfBirth,
    DateTime CreatedAt,
    bool EmailVerified);

public sealed record ExportSettings(string? Locale);

public sealed record ExportEmail(string Address, bool IsVerified, string Source, DateTime CreatedAt);

public sealed record ExportExternalLogin(string Provider, string Subject, DateTime CreatedAt);

public sealed record ExportActivity(string Action, string? FieldName, DateTimeOffset ChangedAt);

public sealed record ExportConsent(
    string Purpose,
    string Status,
    string PolicyVersion,
    DateTimeOffset? GrantedAt,
    DateTimeOffset? WithdrawnAt,
    DateTimeOffset UpdatedAt,
    string Source);

public sealed record AnonymizeResult(int SubjectId, bool AlreadyAnonymized, DateTimeOffset AnonymizedAt);

public sealed record ConsentState(
    int UserId,
    string Purpose,
    string Status,
    string PolicyVersion,
    DateTimeOffset? GrantedAt,
    DateTimeOffset? WithdrawnAt,
    DateTimeOffset? UpdatedAt,
    string? Source);

public sealed record ConsentCommand(string PolicyVersion, string Source);

public sealed record MarketingSendResult(int DispatchId, string Purpose);

public static class PersonalDataExclusions
{
    public static readonly IReadOnlyList<string> Fields =
    [
        "password",
        "passwordResetToken",
        "passwordResetTokenExpiresAt",
        "emailVerificationToken",
        "emailVerificationTokenExpiresAt",
        "twoFactorSecret",
        "twoFactorMasterCodeHash",
        "backupCodeHash",
        "verificationToken"
    ];
}
