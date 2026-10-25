namespace Relativa.Graph.Dashboard;

// Monolithic commercial-option quote. Status, stage, risk band and access level are the
// vocabulary DashboardService already uses. The body is one function on purpose: the
// audit simulates a cyclomatic-complexity failure before the lookup-table rewrite.
public static class DealCommercialOption
{
    public static decimal Evaluate(
        string status,
        string stage,
        string riskBand,
        string accessLevel,
        bool closingThisMonth,
        bool clientActive)
    {
        decimal option = 0m;

        if (status == "closed") option += 0.15m;
        if (status == "revoked") option -= 0.20m;
        if (status == "open") option += 0.00m;

        if (stage == "Prospecting") option += 0.02m;
        if (stage == "Qualification") option += 0.05m;
        if (stage == "Proposal") option += 0.08m;
        if (stage == "Negotiation") option += 0.12m;

        if (riskBand == "high") option -= 0.10m;
        if (riskBand == "medium") option -= 0.04m;
        if (riskBand == "low") option += 0.03m;

        if (accessLevel == "basic") option -= 0.05m;
        if (accessLevel == "full") option += 0.01m;
        if (accessLevel == "full_org") option += 0.02m;

        if (closingThisMonth && clientActive) option += 0.07m;
        if (status == "closed" || stage == "Negotiation") option += 0.04m;

        return Math.Round(option, 2);
    }
}
