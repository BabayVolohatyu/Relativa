using Relativa.Authentication.Application.Privacy;

namespace Relativa.Authentication.Application.Interfaces;

public interface IPersonalDataService
{
    Task<PrivacyDecision<PersonalDataExport>> ExportAsync(
        int actorUserId,
        int subjectUserId,
        string correlationId,
        CancellationToken ct = default);
}

public interface IAnonymizationService
{
    Task<PrivacyDecision<AnonymizeResult>> AnonymizeAsync(
        int actorUserId,
        int subjectUserId,
        string correlationId,
        CancellationToken ct = default);
}

public interface IConsentService
{
    Task<PrivacyDecision<ConsentState>> GrantAsync(
        int actorUserId,
        int subjectUserId,
        string purpose,
        ConsentCommand command,
        string correlationId,
        CancellationToken ct = default);

    Task<PrivacyDecision<ConsentState>> RevokeAsync(
        int actorUserId,
        int subjectUserId,
        string purpose,
        string correlationId,
        CancellationToken ct = default);
}

public interface IMarketingEmailService
{
    Task<PrivacyDecision<MarketingSendResult>> SendAsync(
        int actorUserId,
        int subjectUserId,
        string purpose,
        string correlationId,
        CancellationToken ct = default);
}
