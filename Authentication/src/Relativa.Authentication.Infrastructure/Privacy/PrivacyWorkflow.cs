using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Relativa.Authentication.Application.Exceptions;
using Relativa.Authentication.Application.Interfaces;
using Relativa.Authentication.Application.Privacy;
using Relativa.Authentication.Application.Services;
using Relativa.Authentication.Infrastructure.Data;
using Relativa.Persistence.Contracts;
using Relativa.Persistence.Entities;

namespace Relativa.Authentication.Infrastructure.Privacy;

public sealed class PrivacyWorkflow(
    AuthDbContext db,
    ConsentPolicyGate gate,
    ILogger<PrivacyWorkflow> logger) : IPersonalDataService, IAnonymizationService, IConsentService, IMarketingEmailService
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase
    };

    public async Task<PrivacyDecision<PersonalDataExport>> ExportAsync(
        int actorUserId,
        int subjectUserId,
        string correlationId,
        CancellationToken ct = default)
    {
        if (actorUserId != subjectUserId)
        {
            Log("personal_data_export", actorUserId, subjectUserId, "denied", correlationId);
            return PrivacyDecision<PersonalDataExport>.Missing();
        }

        var user = await db.Users
            .AsNoTracking()
            .Include(u => u.Settings)
            .Include(u => u.Emails)
            .Include(u => u.ExternalLogins)
            .FirstOrDefaultAsync(u => u.Id == subjectUserId && !u.IsArchived, ct);

        if (user is null)
        {
            Log("personal_data_export", actorUserId, subjectUserId, "denied", correlationId);
            return PrivacyDecision<PersonalDataExport>.Missing();
        }

        var activity = await db.UserAuditLogs
            .AsNoTracking()
            .Where(l => l.TargetUserId == subjectUserId)
            .OrderBy(l => l.ChangedAt)
            .Select(l => new ExportActivity(l.Action, l.FieldName, l.ChangedAt))
            .ToListAsync(ct);

        var consents = await db.UserConsents
            .AsNoTracking()
            .Where(c => c.UserId == subjectUserId)
            .OrderBy(c => c.Purpose)
            .Select(c => new ExportConsent(
                c.Purpose, c.Status, c.PolicyVersion, c.GrantedAt, c.WithdrawnAt, c.UpdatedAt, c.Source))
            .ToListAsync(ct);

        var generatedAt = DateTimeOffset.UtcNow;
        var export = new PersonalDataExport(
            SchemaVersion: 1,
            Meta: new ExportMeta(1, generatedAt, user.Id, correlationId),
            Profile: new ExportProfile(
                user.Id, user.FirstName, user.LastName, user.Email, user.Phone,
                user.DateOfBirth, user.CreatedAt, user.EmailVerified),
            Settings: new ExportSettings(user.Settings?.Locale),
            Emails: user.Emails
                .OrderBy(e => e.Id)
                .Select(e => new ExportEmail(e.Address, e.IsVerified, e.Source, e.CreatedAt))
                .ToList(),
            ExternalLogins: user.ExternalLogins
                .OrderBy(e => e.Id)
                .Select(e => new ExportExternalLogin(e.Provider, e.Subject, e.CreatedAt))
                .ToList(),
            Activity: activity,
            Consents: consents,
            Excluded: PersonalDataExclusions.Fields);

        Log("personal_data_export", actorUserId, subjectUserId, "exported", correlationId);
        return PrivacyDecision<PersonalDataExport>.Ok(export);
    }

    public async Task<PrivacyDecision<AnonymizeResult>> AnonymizeAsync(
        int actorUserId,
        int subjectUserId,
        string correlationId,
        CancellationToken ct = default)
    {
        if (actorUserId != subjectUserId)
        {
            Log("user_anonymized", actorUserId, subjectUserId, "denied", correlationId);
            return PrivacyDecision<AnonymizeResult>.Missing();
        }

        await using var tx = await db.Database.BeginTransactionAsync(ct);
        try
        {
            var user = await db.Users
                .Include(u => u.Emails)
                .Include(u => u.ExternalLogins)
                .Include(u => u.BackupCodes)
                .Include(u => u.Settings)
                .FirstOrDefaultAsync(u => u.Id == subjectUserId, ct);

            if (user is null)
            {
                await tx.RollbackAsync(ct);
                Log("user_anonymized", actorUserId, subjectUserId, "denied", correlationId);
                return PrivacyDecision<AnonymizeResult>.Missing();
            }

            if (user.AnonymizedAt is not null)
            {
                await tx.CommitAsync(ct);
                return PrivacyDecision<AnonymizeResult>.Ok(
                    new AnonymizeResult(user.Id, true, user.AnonymizedAt.Value));
            }

            var originals = CollectIdentifiers(user);
            var now = DateTimeOffset.UtcNow;
            user.FirstName = "Erased";
            user.LastName = "Subject";
            user.Email = $"user-{user.Id}@anonymized.invalid";
            user.Phone = null;
            user.DateOfBirth = null;
            user.Password = null;
            user.PasswordResetToken = null;
            user.PasswordResetTokenExpiresAt = null;
            user.EmailVerified = false;
            user.EmailVerificationToken = null;
            user.EmailVerificationTokenExpiresAt = null;
            user.TwoFactorEnabled = false;
            user.TwoFactorSecret = null;
            user.TwoFactorMasterCodeHash = null;
            user.IsArchived = true;
            user.AnonymizedAt = now;

            db.UserEmails.RemoveRange(user.Emails);
            db.UserExternalLogins.RemoveRange(user.ExternalLogins);
            db.UserBackupCodes.RemoveRange(user.BackupCodes);
            if (user.Settings is not null)
                user.Settings.Locale = "en";

            var audits = await db.UserAuditLogs
                .Where(l => l.TargetUserId == user.Id || l.ChangedById == user.Id)
                .ToListAsync(ct);
            foreach (var audit in audits)
            {
                audit.OldValue?.Dispose();
                audit.NewValue?.Dispose();
                audit.OldValue = null;
                audit.NewValue = null;
            }

            var outbox = await db.AuditOutboxMessages.ToListAsync(ct);
            foreach (var message in outbox)
            {
                if (ReferencesSubject(message.PayloadJson, user.Id, originals))
                    message.PayloadJson = ScrubPayload(message.PayloadJson, originals);
            }

            var occurred = DateTimeOffset.UtcNow;
            var eventId = Guid.NewGuid();
            db.AuditOutboxMessages.Add(new AuditOutboxMessage
            {
                EventId = eventId,
                RoutingKey = $"audit.{AuditRouting.ScopeUser}",
                PayloadJson = JsonSerializer.Serialize(new AuditEventContract(
                    EventId: eventId,
                    SchemaVersion: 1,
                    OccurredAtUtc: occurred,
                    SourceService: "authentication",
                    ActorUserId: actorUserId,
                    AuditScope: AuditRouting.ScopeUser,
                    TargetId: user.Id,
                    Action: "user_anonymized",
                    FieldName: null,
                    EntityType: null,
                    OldValueJson: null,
                    NewValueJson: JsonSerializer.Serialize(new
                    {
                        result = "anonymized",
                        correlationId
                    }))),
                OccurredAtUtc = occurred,
                CreatedAtUtc = occurred,
                PublishAttempts = 0
            });

            await db.SaveChangesAsync(ct);
            await tx.CommitAsync(ct);
            Log("user_anonymized", actorUserId, subjectUserId, "anonymized", correlationId);
            return PrivacyDecision<AnonymizeResult>.Ok(new AnonymizeResult(user.Id, false, now));
        }
        catch
        {
            await tx.RollbackAsync(ct);
            throw;
        }
    }

    public Task<PrivacyDecision<ConsentState>> GrantAsync(
        int actorUserId,
        int subjectUserId,
        string purpose,
        ConsentCommand command,
        string correlationId,
        CancellationToken ct = default) =>
        ChangeConsentAsync(actorUserId, subjectUserId, purpose, command, grant: true, correlationId, ct);

    public Task<PrivacyDecision<ConsentState>> RevokeAsync(
        int actorUserId,
        int subjectUserId,
        string purpose,
        string correlationId,
        CancellationToken ct = default) =>
        ChangeConsentAsync(
            actorUserId,
            subjectUserId,
            purpose,
            new ConsentCommand("", ConsentSource.SettingsUi),
            grant: false,
            correlationId,
            ct);

    public async Task<PrivacyDecision<MarketingSendResult>> SendAsync(
        int actorUserId,
        int subjectUserId,
        string purpose,
        string correlationId,
        CancellationToken ct = default)
    {
        if (!await CanActOnActiveSubject(actorUserId, subjectUserId, ct))
        {
            Log("marketing_email", actorUserId, subjectUserId, "denied", correlationId);
            return PrivacyDecision<MarketingSendResult>.Missing();
        }

        if (!ConsentPurpose.IsKnown(purpose))
            throw new AuthException("invalid_consent_purpose", 400, "Unknown consent purpose.");

        var consent = await db.UserConsents
            .AsNoTracking()
            .FirstOrDefaultAsync(c => c.UserId == subjectUserId && c.Purpose == purpose, ct);

        if (!gate.Allows(consent, purpose))
        {
            Log("marketing_email", actorUserId, subjectUserId, "consent_denied", correlationId);
            throw new AuthException("consent_required", 403, "Consent is required for this operation.");
        }

        var dispatch = new MarketingDispatch
        {
            UserId = subjectUserId,
            Purpose = purpose,
            SentAt = DateTimeOffset.UtcNow,
            CorrelationId = correlationId
        };
        db.MarketingDispatches.Add(dispatch);
        await db.SaveChangesAsync(ct);
        Log("marketing_email", actorUserId, subjectUserId, "sent", correlationId);
        return PrivacyDecision<MarketingSendResult>.Ok(new MarketingSendResult(dispatch.Id, purpose));
    }

    private async Task<PrivacyDecision<ConsentState>> ChangeConsentAsync(
        int actorUserId,
        int subjectUserId,
        string purpose,
        ConsentCommand command,
        bool grant,
        string correlationId,
        CancellationToken ct)
    {
        if (!await CanActOnActiveSubject(actorUserId, subjectUserId, ct))
        {
            Log(grant ? "consent_grant" : "consent_revoke", actorUserId, subjectUserId, "denied", correlationId);
            return PrivacyDecision<ConsentState>.Missing();
        }

        if (!ConsentPurpose.IsKnown(purpose))
            throw new AuthException("invalid_consent_purpose", 400, "Unknown consent purpose.");

        if (grant && !ConsentSource.IsKnown(command.Source))
            throw new AuthException("invalid_consent_source", 400, "Unknown consent source.");

        if (grant && string.IsNullOrWhiteSpace(command.PolicyVersion))
            throw new AuthException("invalid_policy_version", 400, "Policy version is required.");

        var existing = await db.UserConsents
            .FirstOrDefaultAsync(c => c.UserId == subjectUserId && c.Purpose == purpose, ct);
        var now = DateTimeOffset.UtcNow;

        if (grant)
        {
            if (existing is { Status: ConsentStatus.Granted }
                && existing.PolicyVersion == command.PolicyVersion)
            {
                return PrivacyDecision<ConsentState>.Ok(ToState(existing));
            }

            if (existing is null)
            {
                existing = new UserConsent
                {
                    UserId = subjectUserId,
                    Purpose = purpose
                };
                db.UserConsents.Add(existing);
            }

            existing.Status = ConsentStatus.Granted;
            existing.PolicyVersion = command.PolicyVersion;
            existing.Source = command.Source;
            existing.GrantedAt = now;
            existing.WithdrawnAt = null;
            existing.UpdatedAt = now;
            db.UserConsentEvents.Add(new UserConsentEvent
            {
                UserId = subjectUserId,
                Purpose = purpose,
                Action = "grant",
                PolicyVersion = command.PolicyVersion,
                Source = command.Source,
                OccurredAt = now
            });
        }
        else if (existing is null || existing.Status == ConsentStatus.Withdrawn)
        {
            return PrivacyDecision<ConsentState>.Ok(existing is null
                ? new ConsentState(subjectUserId, purpose, ConsentStatus.Withdrawn, "", null, null, null, null)
                : ToState(existing));
        }
        else
        {
            existing.Status = ConsentStatus.Withdrawn;
            existing.WithdrawnAt = now;
            existing.UpdatedAt = now;
            db.UserConsentEvents.Add(new UserConsentEvent
            {
                UserId = subjectUserId,
                Purpose = purpose,
                Action = "revoke",
                PolicyVersion = existing.PolicyVersion,
                Source = existing.Source,
                OccurredAt = now
            });
        }

        await db.SaveChangesAsync(ct);
        Log(grant ? "consent_grant" : "consent_revoke", actorUserId, subjectUserId, "ok", correlationId);
        return PrivacyDecision<ConsentState>.Ok(ToState(existing!));
    }

    private async Task<bool> CanActOnActiveSubject(int actorUserId, int subjectUserId, CancellationToken ct)
    {
        if (actorUserId != subjectUserId)
            return false;

        return await db.Users.AnyAsync(u => u.Id == subjectUserId && !u.IsArchived, ct);
    }

    private static ConsentState ToState(UserConsent consent) => new(
        consent.UserId,
        consent.Purpose,
        consent.Status,
        consent.PolicyVersion,
        consent.GrantedAt,
        consent.WithdrawnAt,
        consent.UpdatedAt,
        consent.Source);

    private static List<string> CollectIdentifiers(User user)
    {
        var values = new List<string> { user.Email, user.FirstName, user.LastName };
        if (!string.IsNullOrWhiteSpace(user.Phone))
            values.Add(user.Phone);
        if (!string.IsNullOrWhiteSpace(user.Password))
            values.Add(user.Password);
        if (!string.IsNullOrWhiteSpace(user.PasswordResetToken))
            values.Add(user.PasswordResetToken);
        if (!string.IsNullOrWhiteSpace(user.EmailVerificationToken))
            values.Add(user.EmailVerificationToken);
        if (!string.IsNullOrWhiteSpace(user.TwoFactorSecret))
            values.Add(user.TwoFactorSecret);
        values.AddRange(user.Emails.Select(e => e.Address));
        values.AddRange(user.Emails.Select(e => e.VerificationToken).Where(t => !string.IsNullOrWhiteSpace(t))!);
        values.AddRange(user.ExternalLogins.Select(l => l.Subject));
        values.AddRange(user.BackupCodes.Select(c => c.CodeHash));
        return values.Where(v => !string.IsNullOrWhiteSpace(v)).Distinct(StringComparer.Ordinal).ToList();
    }

    private static bool ReferencesSubject(string payload, int userId, IReadOnlyList<string> originals) =>
        payload.Contains($"\"TargetId\":{userId}", StringComparison.Ordinal)
        || payload.Contains($"\"ActorUserId\":{userId}", StringComparison.Ordinal)
        || originals.Any(value => value.Length >= 3 && payload.Contains(value, StringComparison.Ordinal));

    private static string ScrubPayload(string payload, IReadOnlyList<string> originals)
    {
        try
        {
            var node = JsonNodeParse(payload);
            if (node is System.Text.Json.Nodes.JsonObject obj)
            {
                obj["OldValueJson"] = null;
                obj["NewValueJson"] = null;
                payload = obj.ToJsonString();
            }
        }
        catch (JsonException)
        {
            // Fall through to literal replacement when the payload is not an object.
        }

        foreach (var value in originals.Where(v => v.Length >= 3))
            payload = payload.Replace(value, "", StringComparison.Ordinal);

        return payload;
    }

    private static System.Text.Json.Nodes.JsonNode? JsonNodeParse(string payload) =>
        System.Text.Json.Nodes.JsonNode.Parse(payload);

    private void Log(string action, int actorUserId, int subjectUserId, string result, string correlationId) =>
        logger.LogInformation(
            "privacy {Action} actor {ActorId} subject {SubjectId} result {Result} correlation {CorrelationId}",
            action,
            actorUserId,
            subjectUserId,
            result,
            correlationId);
}
