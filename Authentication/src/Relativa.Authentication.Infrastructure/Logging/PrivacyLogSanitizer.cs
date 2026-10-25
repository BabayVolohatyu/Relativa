using System.Text.RegularExpressions;

namespace Relativa.Authentication.Infrastructure.Logging;

public static partial class PrivacyLogSanitizer
{
    public const string Redacted = "[REDACTED]";

    public static string SanitizeText(string? value)
    {
        if (string.IsNullOrEmpty(value))
            return value ?? "";

        var text = BearerRegex().Replace(value, "Bearer " + Redacted);
        text = JwtRegex().Replace(text, Redacted);
        text = SecretAssignmentRegex().Replace(text, "$1=" + Redacted);
        text = EmailRegex().Replace(text, match => MaskEmail(match.Value));
        text = PhoneRegex().Replace(text, match => MaskPhone(match.Value));
        return text;
    }

    public static string MaskEmail(string value)
    {
        var at = value.IndexOf('@');
        if (at <= 0)
            return Redacted;

        return $"{value[0]}***{value[at..]}";
    }

    public static string MaskPhone(string value)
    {
        var digits = new string(value.Where(char.IsDigit).ToArray());
        if (digits.Length < 2)
            return Redacted;

        return "***" + digits[^2..];
    }

    public static bool IsSecretName(string name)
    {
        var normalized = name.Replace("_", "", StringComparison.Ordinal)
            .Replace("-", "", StringComparison.Ordinal);
        return normalized.Contains("password", StringComparison.OrdinalIgnoreCase)
            || normalized.Contains("token", StringComparison.OrdinalIgnoreCase)
            || normalized.Contains("secret", StringComparison.OrdinalIgnoreCase)
            || normalized.Contains("apikey", StringComparison.OrdinalIgnoreCase)
            || normalized.Contains("authorization", StringComparison.OrdinalIgnoreCase)
            || normalized.Contains("codehash", StringComparison.OrdinalIgnoreCase)
            || normalized.Contains("mastercode", StringComparison.OrdinalIgnoreCase)
            || normalized.Contains("session", StringComparison.OrdinalIgnoreCase);
    }

    public static bool IsEmailName(string name) =>
        name.Contains("email", StringComparison.OrdinalIgnoreCase)
        || name.Equals("address", StringComparison.OrdinalIgnoreCase);

    public static bool IsPhoneName(string name) =>
        name.Contains("phone", StringComparison.OrdinalIgnoreCase)
        || name.Contains("mobile", StringComparison.OrdinalIgnoreCase);

    [GeneratedRegex(@"Bearer\s+\S+", RegexOptions.IgnoreCase)]
    private static partial Regex BearerRegex();

    [GeneratedRegex(@"eyJ[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+")]
    private static partial Regex JwtRegex();

    [GeneratedRegex(@"(?i)\b(password|token|secret|api[_-]?key)\b\s*[:=]\s*\S+")]
    private static partial Regex SecretAssignmentRegex();

    [GeneratedRegex(@"[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}")]
    private static partial Regex EmailRegex();

    [GeneratedRegex(@"\+\d{8,15}")]
    private static partial Regex PhoneRegex();
}
