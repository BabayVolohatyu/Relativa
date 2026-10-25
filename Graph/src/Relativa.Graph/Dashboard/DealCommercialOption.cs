namespace Relativa.Graph.Dashboard;

// Lookup-table quote. The same deal vocabulary as DashboardService, with no
// conditional branches: each rule is a key in a static dictionary.
public static class DealCommercialOption
{
    private static readonly Dictionary<string, decimal> StatusDelta = new()
    {
        ["closed"] = 0.15m,
        ["revoked"] = -0.20m,
        ["open"] = 0.00m,
    };

    private static readonly Dictionary<string, decimal> StageDelta = new()
    {
        ["Prospecting"] = 0.02m,
        ["Qualification"] = 0.05m,
        ["Proposal"] = 0.08m,
        ["Negotiation"] = 0.12m,
    };

    private static readonly Dictionary<string, decimal> RiskDelta = new()
    {
        ["high"] = -0.10m,
        ["medium"] = -0.04m,
        ["low"] = 0.03m,
    };

    private static readonly Dictionary<string, decimal> AccessDelta = new()
    {
        ["basic"] = -0.05m,
        ["full"] = 0.01m,
        ["full_org"] = 0.02m,
    };

    private static readonly Dictionary<(bool Closing, bool Active), decimal> ClosingDelta = new()
    {
        [(true, true)] = 0.07m,
    };

    // status == "closed" || stage == "Negotiation", enumerated for the three statuses
    // and four stages the dashboard already writes.
    private static readonly Dictionary<(string Status, string Stage), decimal> ClosedOrNegotiation = new()
    {
        [("closed", "Prospecting")] = 0.04m,
        [("closed", "Qualification")] = 0.04m,
        [("closed", "Proposal")] = 0.04m,
        [("closed", "Negotiation")] = 0.04m,
        [("open", "Negotiation")] = 0.04m,
        [("revoked", "Negotiation")] = 0.04m,
    };

    public static decimal Evaluate(
        string status,
        string stage,
        string riskBand,
        string accessLevel,
        bool closingThisMonth,
        bool clientActive) =>
        Math.Round(
            StatusDelta.GetValueOrDefault(status)
            + StageDelta.GetValueOrDefault(stage)
            + RiskDelta.GetValueOrDefault(riskBand)
            + AccessDelta.GetValueOrDefault(accessLevel)
            + ClosingDelta.GetValueOrDefault((closingThisMonth, clientActive))
            + ClosedOrNegotiation.GetValueOrDefault((status, stage)),
            2);

    private static readonly Dictionary<int, int> LegacyTierScore = new()
    {
        [0] = 0,
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
        [10] = 10,
    };

    public static int ScoreLegacyTier(int tier) =>
        LegacyTierScore.GetValueOrDefault(tier, -1);
}
