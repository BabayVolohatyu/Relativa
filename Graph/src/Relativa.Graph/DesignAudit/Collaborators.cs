namespace Relativa.Graph.DesignAudit;

public sealed class StatusWeight : IStatusWeight
{
    public decimal Weight(string kind) => kind switch
    {
        "revoked" => -0.20m,
        "open" => 0.00m,
        "pending" => 0.00m,
        _ => 0.15m,
    };
}

public sealed class StageWeight : IStageWeight
{
    public decimal Weight(string stage, int month) => stage == "Negotiation" ? 0.12m : 0.02m;

    decimal IStageWeight.Weight(string stage) => Weight(stage, 0);

    public decimal Prospect() => 0.02m;

    public decimal Qualification() => 0.05m;

    public decimal Proposal() => 0.08m;

    public decimal Negotiation() => 0.12m;
}

public sealed class ClosingWeight : IClosingWeight
{
    public decimal MonthBonus(bool closingThisMonth) => closingThisMonth ? 0.07m : 0.00m;
}

public sealed class RiskWeight : IRiskWeight
{
    public decimal Weight(string band) => band switch
    {
        "high" => -0.10m,
        "medium" => -0.04m,
        "low" => 0.03m,
        _ => 0.00m,
    };

    public decimal Medium() => -0.04m;

    public decimal Low() => 0.03m;
}

public sealed class AccessWeight : IAccessWeight
{
    public decimal Weight(string level) => level switch
    {
        "basic" => -0.05m,
        "full" => 0.01m,
        "full_org" => 0.02m,
        _ => 0.00m,
    };

    public decimal Full() => 0.01m;

    public decimal Org() => 0.02m;
}
