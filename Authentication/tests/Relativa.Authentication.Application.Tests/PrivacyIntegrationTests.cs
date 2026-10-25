using System.Text.Json;
using DotNet.Testcontainers.Builders;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Relativa.Authentication.Application.Exceptions;
using Relativa.Authentication.Application.Options;
using Relativa.Authentication.Application.Privacy;
using Relativa.Authentication.Application.Services;
using Relativa.Authentication.Infrastructure.Data;
using Relativa.Authentication.Infrastructure.Privacy;
using Relativa.Persistence.Entities;
using Relativa.Persistence.Entities.AuditLogs;
using Testcontainers.PostgreSql;
using Xunit;

namespace Relativa.Authentication.Application.Tests;

public sealed class PrivacyIntegrationTests : IAsyncLifetime
{
    private readonly PostgreSqlContainer _postgres = new PostgreSqlBuilder()
        .WithImage("postgres:16-alpine")
        .WithDatabase("auth_privacy_test")
        .WithUsername("relativa")
        .WithPassword("test")
        .WithWaitStrategy(Wait.ForUnixContainer().UntilPortIsAvailable(5432))
        .Build();

    private DbContextOptions<AuthDbContext> _opts = null!;

    public async Task InitializeAsync()
    {
        await _postgres.StartAsync();
        _opts = new DbContextOptionsBuilder<AuthDbContext>()
            .UseNpgsql(_postgres.GetConnectionString())
            .Options;
        await using var db = new AuthDbContext(_opts);
        await db.Database.EnsureCreatedAsync();
    }

    public async Task DisposeAsync() => await _postgres.DisposeAsync();

    [Fact]
    public async Task Export_IncludesEverySource_OmitsSecrets_AndDeniesForeignAndMissingIds()
    {
        var email = "ada.export@example.test";
        var phone = "+15555550199";
        var secret = "export-password-hash";
        var reset = "export-reset-token";
        var twoFactor = "export-two-factor-secret";
        await using var db = new AuthDbContext(_opts);
        var user = await SeedSubjectAsync(db, email, phone, secret, reset, twoFactor);
        var other = await SeedSubjectAsync(db, "grace.export@example.test", null, "other-hash", null, null);
        var logs = new CollectingLogger<PrivacyWorkflow>();
        var workflow = Workflow(db, logs);

        var exported = await workflow.ExportAsync(user.Id, user.Id, "corr-export");
        exported.Found.Should().BeTrue();
        var body = exported.Value!;
        body.SchemaVersion.Should().Be(1);
        body.Meta.SubjectId.Should().Be(user.Id);
        body.Meta.CorrelationId.Should().Be("corr-export");
        body.Profile.Email.Should().Be(email);
        body.Profile.Phone.Should().Be(phone);
        body.Settings.Locale.Should().Be("uk");
        body.Emails.Should().ContainSingle(e => e.Address == "alias." + email);
        body.ExternalLogins.Should().ContainSingle(e => e.Subject == "subject-" + email);
        body.Activity.Should().ContainSingle(a => a.Action == "user_profile_updated");
        body.Consents.Should().ContainSingle(c => c.Purpose == ConsentPurpose.MarketingEmail);
        body.Excluded.Should().Contain("password");

        var json = JsonSerializer.Serialize(body, new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase });
        json.Should().NotContain(secret);
        json.Should().NotContain(reset);
        json.Should().NotContain(twoFactor);
        json.Should().NotContain("backup-export");
        AssertSecretNamesOnlyInsideExcluded(json);

        var foreign = await workflow.ExportAsync(other.Id, user.Id, "corr-foreign");
        var missing = await workflow.ExportAsync(user.Id, 999999, "corr-missing");
        foreign.Found.Should().BeFalse();
        foreign.Value.Should().BeNull();
        missing.Found.Should().BeFalse();
        missing.Value.Should().BeNull();
        logs.Messages.Should().Contain(m => m.Contains("denied") && m.Contains("corr-export") == false);
        logs.Messages.Should().NotContain(m => m.Contains(email));
    }

    [Fact]
    public async Task Anonymize_RemovesPii_KeepsRetainedRows_IsIdempotent_AndRollsBack()
    {
        await using var db = new AuthDbContext(_opts);
        var email = "ada.erase@example.test";
        var user = await SeedSubjectAsync(db, email, "+15555550123", "erase-password", "erase-reset", "erase-secret");
        db.UserConsents.Add(new UserConsent
        {
            UserId = user.Id,
            Purpose = ConsentPurpose.MarketingEmail,
            Status = ConsentStatus.Granted,
            PolicyVersion = LabPrivacyUsers.PolicyVersion,
            Source = ConsentSource.SettingsUi,
            GrantedAt = DateTimeOffset.UtcNow,
            UpdatedAt = DateTimeOffset.UtcNow
        });
        db.MarketingDispatches.Add(new MarketingDispatch
        {
            UserId = user.Id,
            Purpose = ConsentPurpose.MarketingEmail,
            SentAt = DateTimeOffset.UtcNow,
            CorrelationId = "dispatch-keep"
        });
        await db.SaveChangesAsync();

        var workflow = Workflow(db, new CollectingLogger<PrivacyWorkflow>());
        var first = await workflow.AnonymizeAsync(user.Id, user.Id, "corr-erase");
        first.Found.Should().BeTrue();
        first.Value!.AlreadyAnonymized.Should().BeFalse();

        db.ChangeTracker.Clear();
        var stored = await db.Users.Include(u => u.Settings).SingleAsync(u => u.Id == user.Id);
        stored.Email.Should().Be($"user-{user.Id}@anonymized.invalid");
        stored.FirstName.Should().Be("Erased");
        stored.LastName.Should().Be("Subject");
        stored.Phone.Should().BeNull();
        stored.Password.Should().BeNull();
        stored.PasswordResetToken.Should().BeNull();
        stored.TwoFactorSecret.Should().BeNull();
        stored.IsArchived.Should().BeTrue();
        stored.AnonymizedAt.Should().NotBeNull();
        stored.Settings!.Locale.Should().Be("en");
        (await db.UserEmails.AnyAsync(e => e.UserId == user.Id)).Should().BeFalse();
        (await db.UserExternalLogins.AnyAsync(e => e.UserId == user.Id)).Should().BeFalse();
        (await db.UserBackupCodes.AnyAsync(c => c.UserId == user.Id)).Should().BeFalse();
        (await db.UserConsents.AnyAsync(c => c.UserId == user.Id)).Should().BeTrue();
        (await db.MarketingDispatches.AnyAsync(d => d.CorrelationId == "dispatch-keep")).Should().BeTrue();

        var audits = await db.UserAuditLogs.Where(l => l.TargetUserId == user.Id).ToListAsync();
        audits.Should().NotBeEmpty();
        audits.Should().OnlyContain(a => a.OldValue == null && a.NewValue == null);
        var payloads = await db.AuditOutboxMessages.Select(m => m.PayloadJson).ToListAsync();
        payloads.Should().NotContain(p => p.Contains(email));
        payloads.Should().Contain(p => p.Contains("user_anonymized") && p.Contains("corr-erase"));

        var second = await workflow.AnonymizeAsync(user.Id, user.Id, "corr-erase-2");
        second.Value!.AlreadyAnonymized.Should().BeTrue();
        db.ChangeTracker.Clear();
        (await db.Users.Where(u => u.Id == user.Id).Select(u => u.Email).SingleAsync())
            .Should().Be($"user-{user.Id}@anonymized.invalid");
        var afterPayloads = await db.AuditOutboxMessages.Select(m => m.PayloadJson).ToListAsync();
        afterPayloads.Count(p => p.Contains("corr-erase-2", StringComparison.Ordinal)).Should().Be(0);

        var stranger = await SeedSubjectAsync(db, "grace.erase@example.test", null, "x", null, null);
        var denied = await workflow.AnonymizeAsync(stranger.Id, user.Id, "corr-deny");
        denied.Found.Should().BeFalse();

        var rollbackEmail = "ada.rollback@example.test";
        var rollbackUser = await SeedSubjectAsync(db, rollbackEmail, "+15555550111", "rb-password", null, null);
        var throwing = new DbContextOptionsBuilder<AuthDbContext>()
            .UseNpgsql(_postgres.GetConnectionString())
            .AddInterceptors(new ThrowOnSaveInterceptor())
            .Options;
        await using var failing = new AuthDbContext(throwing);
        var failingWorkflow = Workflow(failing, new CollectingLogger<PrivacyWorkflow>());
        var act = () => failingWorkflow.AnonymizeAsync(rollbackUser.Id, rollbackUser.Id, "corr-rollback");
        await act.Should().ThrowAsync<InvalidOperationException>();

        db.ChangeTracker.Clear();
        (await db.Users.Where(u => u.Id == rollbackUser.Id).Select(u => u.Email).SingleAsync())
            .Should().Be(rollbackEmail);
    }

    [Fact]
    public async Task Consent_GrantAllows_RevokeDenies_AndPurposesStayIsolated()
    {
        await using var db = new AuthDbContext(_opts);
        var user = await SeedSubjectAsync(db, "ada.consent@example.test", "+15555550122", "consent-hash", null, null);
        var workflow = Workflow(db, new CollectingLogger<PrivacyWorkflow>());

        var denied = () => workflow.SendAsync(user.Id, user.Id, ConsentPurpose.MarketingEmail, "corr-1");
        await denied.Should().ThrowAsync<AuthException>()
            .Where(ex => ex.Code == "consent_required" && ex.StatusCode == 403);
        (await db.MarketingDispatches.CountAsync(d => d.UserId == user.Id)).Should().Be(0);

        var granted = await workflow.GrantAsync(
            user.Id, user.Id, ConsentPurpose.MarketingEmail,
            new ConsentCommand(LabPrivacyUsers.PolicyVersion, ConsentSource.SettingsUi), "corr-2");
        granted.Found.Should().BeTrue();
        granted.Value!.Status.Should().Be(ConsentStatus.Granted);

        var repeat = await workflow.GrantAsync(
            user.Id, user.Id, ConsentPurpose.MarketingEmail,
            new ConsentCommand(LabPrivacyUsers.PolicyVersion, ConsentSource.SettingsUi), "corr-3");
        repeat.Value!.GrantedAt.Should().Be(granted.Value.GrantedAt);
        (await db.UserConsentEvents.CountAsync(e => e.UserId == user.Id && e.Action == "grant")).Should().Be(1);

        var sent = await workflow.SendAsync(user.Id, user.Id, ConsentPurpose.MarketingEmail, "corr-4");
        sent.Found.Should().BeTrue();
        (await db.MarketingDispatches.CountAsync(d => d.UserId == user.Id)).Should().Be(1);

        var analytics = () => workflow.SendAsync(user.Id, user.Id, ConsentPurpose.OptionalAnalytics, "corr-5");
        await analytics.Should().ThrowAsync<AuthException>().Where(ex => ex.Code == "consent_required");
        (await db.MarketingDispatches.CountAsync(d => d.UserId == user.Id)).Should().Be(1);

        var revoked = await workflow.RevokeAsync(user.Id, user.Id, ConsentPurpose.MarketingEmail, "corr-6");
        revoked.Value!.Status.Should().Be(ConsentStatus.Withdrawn);
        var revokedAgain = await workflow.RevokeAsync(user.Id, user.Id, ConsentPurpose.MarketingEmail, "corr-7");
        revokedAgain.Value!.WithdrawnAt.Should().Be(revoked.Value.WithdrawnAt);
        (await db.UserConsentEvents.CountAsync(e => e.UserId == user.Id && e.Action == "revoke")).Should().Be(1);

        var after = () => workflow.SendAsync(user.Id, user.Id, ConsentPurpose.MarketingEmail, "corr-8");
        await after.Should().ThrowAsync<AuthException>().Where(ex => ex.Code == "consent_required");
        (await db.MarketingDispatches.CountAsync(d => d.UserId == user.Id)).Should().Be(1);

        var stranger = await SeedSubjectAsync(db, "grace.consent@example.test", null, "x", null, null);
        var foreign = await workflow.GrantAsync(
            stranger.Id, user.Id, ConsentPurpose.MarketingEmail,
            new ConsentCommand(LabPrivacyUsers.PolicyVersion, ConsentSource.SettingsUi), "corr-9");
        foreign.Found.Should().BeFalse();
    }

    private PrivacyWorkflow Workflow(AuthDbContext db, ILogger<PrivacyWorkflow> logger) =>
        new(db, new ConsentPolicyGate(Microsoft.Extensions.Options.Options.Create(new ConsentOptions())), logger);

    private static async Task<User> SeedSubjectAsync(
        AuthDbContext db,
        string email,
        string? phone,
        string password,
        string? resetToken,
        string? twoFactorSecret)
    {
        var user = new User
        {
            FirstName = "Ada",
            LastName = "Lovelace",
            Email = email,
            Phone = phone,
            Password = password,
            PasswordResetToken = resetToken,
            TwoFactorSecret = twoFactorSecret,
            CreatedAt = DateTime.UtcNow,
            EmailVerified = true,
            Settings = new UserSettings { Locale = "uk" },
            Emails =
            [
                new UserEmail
                {
                    Address = "alias." + email,
                    IsVerified = true,
                    Source = "manual",
                    VerificationToken = "verify-" + email,
                    CreatedAt = DateTime.UtcNow
                }
            ],
            ExternalLogins =
            [
                new UserExternalLogin
                {
                    Provider = "google",
                    Subject = "subject-" + email,
                    CreatedAt = DateTime.UtcNow
                }
            ],
            BackupCodes =
            [
                new UserBackupCode
                {
                    CodeHash = "backup-" + email,
                    CreatedAt = DateTime.UtcNow
                }
            ]
        };
        db.Users.Add(user);
        await db.SaveChangesAsync();

        db.UserAuditLogs.Add(new UserAuditLog
        {
            Id = Guid.NewGuid(),
            Action = "user_profile_updated",
            TargetUserId = user.Id,
            ChangedById = user.Id,
            FieldName = "email",
            NewValue = JsonDocument.Parse($$"""{"email":"{{email}}"}"""),
            ChangedAt = DateTimeOffset.UtcNow
        });
        db.AuditOutboxMessages.Add(new AuditOutboxMessage
        {
            EventId = Guid.NewGuid(),
            RoutingKey = "audit.user",
            PayloadJson = $$"""{"ActorUserId":{{user.Id}},"TargetId":{{user.Id}},"Action":"user_profile_updated","OldValueJson":null,"NewValueJson":"{\"email\":\"{{email}}\"}"}""",
            OccurredAtUtc = DateTimeOffset.UtcNow,
            CreatedAtUtc = DateTimeOffset.UtcNow
        });
        if (email.Contains("export", StringComparison.Ordinal))
        {
            db.UserConsents.Add(new UserConsent
            {
                UserId = user.Id,
                Purpose = ConsentPurpose.MarketingEmail,
                Status = ConsentStatus.Granted,
                PolicyVersion = LabPrivacyUsers.PolicyVersion,
                Source = ConsentSource.SettingsUi,
                GrantedAt = DateTimeOffset.UtcNow,
                UpdatedAt = DateTimeOffset.UtcNow
            });
        }

        await db.SaveChangesAsync();
        return user;
    }

    private static void AssertSecretNamesOnlyInsideExcluded(string json)
    {
        using var doc = JsonDocument.Parse(json);
        Walk(doc.RootElement, null);

        static void Walk(JsonElement element, string? parent)
        {
            if (element.ValueKind == JsonValueKind.Object)
            {
                foreach (var property in element.EnumerateObject())
                {
                    if (!string.Equals(parent, "excluded", StringComparison.Ordinal)
                        && PersonalDataExclusions.Fields.Contains(property.Name))
                    {
                        throw new Xunit.Sdk.XunitException($"Forbidden field '{property.Name}' was exported.");
                    }

                    Walk(property.Value, property.Name);
                }
            }
            else if (element.ValueKind == JsonValueKind.Array && !string.Equals(parent, "excluded", StringComparison.Ordinal))
            {
                foreach (var item in element.EnumerateArray())
                    Walk(item, parent);
            }
        }
    }

    private sealed class ThrowOnSaveInterceptor : SaveChangesInterceptor
    {
        public override InterceptionResult<int> SavingChanges(DbContextEventData eventData, InterceptionResult<int> result) =>
            throw new InvalidOperationException("forced save failure");

        public override ValueTask<InterceptionResult<int>> SavingChangesAsync(
            DbContextEventData eventData,
            InterceptionResult<int> result,
            CancellationToken cancellationToken = default) =>
            throw new InvalidOperationException("forced save failure");
    }

    private sealed class CollectingLogger<T> : ILogger<T>
    {
        public List<string> Messages { get; } = [];

        public IDisposable? BeginScope<TState>(TState state) where TState : notnull => null;

        public bool IsEnabled(LogLevel logLevel) => true;

        public void Log<TState>(
            LogLevel logLevel,
            EventId eventId,
            TState state,
            Exception? exception,
            Func<TState, Exception?, string> formatter) =>
            Messages.Add(formatter(state, exception));
    }
}
