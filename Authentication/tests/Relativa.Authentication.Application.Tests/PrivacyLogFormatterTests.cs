using FluentAssertions;
using Relativa.Authentication.Application.Privacy;
using Relativa.Authentication.Infrastructure.Logging;
using Serilog;
using Serilog.Core;
using Serilog.Events;
using Xunit;

namespace Relativa.Authentication.Application.Tests;

public sealed class PrivacyLogFormatterTests
{
    [Fact]
    public void Positive_MasksIdentifiers_AndRedactsSecrets()
    {
        var text = Capture(log => log.Information(
            "privacy log probe correlation {CorrelationId} {@Payload}",
            "11111111-1111-1111-1111-111111111111",
            new
            {
                Email = LabPrivacyUsers.SubjectEmail,
                Phone = LabPrivacyUsers.Phone,
                Nested = new { Password = LabPrivacyUsers.Password, Token = LabPrivacyUsers.Token }
            }));

        text.Should().NotContain(LabPrivacyUsers.SubjectEmail);
        text.Should().NotContain(LabPrivacyUsers.Phone);
        text.Should().NotContain(LabPrivacyUsers.Password);
        text.Should().NotContain(LabPrivacyUsers.Token);
        text.Should().Contain("a***@example.test");
        text.Should().Contain("***23");
        text.Should().Contain(PrivacyLogSanitizer.Redacted);
        text.Should().Contain("11111111-1111-1111-1111-111111111111");
        text.Trim().Should().StartWith("{").And.EndWith("}");
    }

    [Fact]
    public void Negative_NestedDtoAndException_DoNotLeakOriginalValues()
    {
        var text = Capture(log =>
        {
            try
            {
                throw new InvalidOperationException(
                    $"token={LabPrivacyUsers.Token} email={LabPrivacyUsers.SubjectEmail} phone={LabPrivacyUsers.Phone}");
            }
            catch (Exception ex)
            {
                log.Warning(
                    ex,
                    "privacy log probe rejected correlation {CorrelationId} {@Payload}",
                    "11111111-1111-1111-1111-111111111111",
                    new
                    {
                        Email = LabPrivacyUsers.SubjectEmail,
                        Phone = LabPrivacyUsers.Phone,
                        Nested = new { Password = LabPrivacyUsers.Password, Token = LabPrivacyUsers.Token }
                    });
            }
        });

        text.Should().NotContain(LabPrivacyUsers.SubjectEmail);
        text.Should().NotContain(LabPrivacyUsers.Phone);
        text.Should().NotContain(LabPrivacyUsers.Password);
        text.Should().NotContain(LabPrivacyUsers.Token);
        text.Should().Contain("11111111-1111-1111-1111-111111111111");
    }

    private static string Capture(Action<ILogger> write)
    {
        using var writer = new StringWriter();
        var log = new LoggerConfiguration()
            .WriteTo.Sink(new FormatterSink(writer, new PrivacyLogTextFormatter()))
            .CreateLogger();
        write(log);
        log.Dispose();
        return writer.ToString();
    }

    private sealed class FormatterSink(TextWriter writer, Serilog.Formatting.ITextFormatter formatter) : ILogEventSink
    {
        public void Emit(LogEvent logEvent) => formatter.Format(logEvent, writer);
    }
}
