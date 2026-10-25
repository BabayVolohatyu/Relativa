namespace Relativa.Graph.DesignAudit;

public sealed class StatusWeight
{
    public decimal Weight() => 0.15m;
}

public sealed class RevokeWeight
{
    public decimal Weight() => -0.20m;
}

public sealed class OpenWeight
{
    public decimal Weight() => 0.00m;
}

public sealed class PendingWeight
{
    public decimal Weight() => 0.00m;
}

public sealed class StageWeight
{
    public decimal Weight(string stage) => stage == "Negotiation" ? 0.12m : 0.02m;
}

public sealed class ProspectWeight
{
    public decimal Weight() => 0.02m;
}

public sealed class QualificationWeight
{
    public decimal Weight() => 0.05m;
}

public sealed class ProposalWeight
{
    public decimal Weight() => 0.08m;
}

public sealed class NegotiationWeight
{
    public decimal Weight() => 0.12m;
}

public sealed class RiskWeight
{
    public decimal Weight(string band) => band switch
    {
        "high" => -0.10m,
        "medium" => -0.04m,
        "low" => 0.03m,
        _ => 0.00m,
    };
}

public sealed class MediumRiskWeight
{
    public decimal Weight() => -0.04m;
}

public sealed class LowRiskWeight
{
    public decimal Weight() => 0.03m;
}

public sealed class AccessWeight
{
    public decimal Weight(string level) => level switch
    {
        "basic" => -0.05m,
        "full" => 0.01m,
        "full_org" => 0.02m,
        _ => 0.00m,
    };
}

public sealed class FullAccessWeight
{
    public decimal Weight() => 0.01m;
}

public sealed class OrgAccessWeight
{
    public decimal Weight() => 0.02m;
}

public sealed class DeskClock
{
    public string Stamp() => "desk";
}
