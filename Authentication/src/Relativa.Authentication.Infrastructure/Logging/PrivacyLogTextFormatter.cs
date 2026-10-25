using System.Text.Json;
using Serilog.Events;
using Serilog.Formatting;

namespace Relativa.Authentication.Infrastructure.Logging;

public sealed class PrivacyLogTextFormatter : ITextFormatter
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase
    };

    public void Format(LogEvent logEvent, TextWriter output)
    {
        var secrets = new List<string>();
        var properties = new Dictionary<string, object?>();
        foreach (var property in logEvent.Properties)
            properties[property.Key] = Box(property.Value, property.Key, secrets);

        var message = PrivacyLogSanitizer.SanitizeText(logEvent.RenderMessage());
        string? exception = logEvent.Exception is null
            ? null
            : PrivacyLogSanitizer.SanitizeText(logEvent.Exception.ToString());

        var payload = new Dictionary<string, object?>
        {
            ["timestamp"] = logEvent.Timestamp.UtcDateTime.ToString("O"),
            ["level"] = logEvent.Level.ToString(),
            ["message"] = message,
            ["exception"] = exception,
            ["properties"] = properties
        };

        var json = JsonSerializer.Serialize(payload, JsonOptions);
        foreach (var secret in secrets.Where(s => s.Length >= 6).Distinct(StringComparer.Ordinal))
            json = json.Replace(secret, PrivacyLogSanitizer.Redacted, StringComparison.Ordinal);

        output.Write(json);
        output.WriteLine();
    }

    private static object? Box(LogEventPropertyValue value, string? name, List<string> secrets)
    {
        if (name is not null && PrivacyLogSanitizer.IsSecretName(name))
        {
            if (value is ScalarValue { Value: string secret } && secret.Length >= 6)
                secrets.Add(secret);
            return PrivacyLogSanitizer.Redacted;
        }

        switch (value)
        {
            case ScalarValue { Value: string text }:
                if (name is not null && PrivacyLogSanitizer.IsEmailName(name))
                    return text.Contains('@') ? PrivacyLogSanitizer.MaskEmail(text) : PrivacyLogSanitizer.SanitizeText(text);
                if (name is not null && PrivacyLogSanitizer.IsPhoneName(name))
                    return PrivacyLogSanitizer.MaskPhone(text);
                return PrivacyLogSanitizer.SanitizeText(text);
            case ScalarValue scalar:
                return scalar.Value;
            case StructureValue structure:
                return structure.Properties.ToDictionary(p => p.Name, p => Box(p.Value, p.Name, secrets));
            case SequenceValue sequence:
                return sequence.Elements.Select(item => Box(item, name, secrets)).ToList();
            case DictionaryValue dictionary:
                var map = new Dictionary<string, object?>();
                foreach (var element in dictionary.Elements)
                {
                    var key = element.Key.Value?.ToString() ?? "";
                    map[key] = Box(element.Value, key, secrets);
                }
                return map;
            default:
                return PrivacyLogSanitizer.SanitizeText(value.ToString());
        }
    }
}
