using Microsoft.Extensions.Options;
using Relativa.Authentication.Application.Options;
using Relativa.Authentication.Application.Privacy;
using Relativa.Persistence.Entities;

namespace Relativa.Authentication.Application.Services;

public sealed class ConsentPolicyGate(IOptions<ConsentOptions> options)
{
    public bool Allows(UserConsent? consent, string purpose)
    {
        var required = options.Value.RequiredVersion(purpose);
        return required is not null
            && consent is { Status: ConsentStatus.Granted }
            && string.Equals(consent.PolicyVersion, required, StringComparison.Ordinal);
    }
}
