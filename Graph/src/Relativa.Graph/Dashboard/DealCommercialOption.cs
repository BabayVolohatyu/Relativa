namespace Relativa.Graph.Dashboard;

// Baseline classifier for a deal status. The closed and revoked outcomes are the
// same labels DashboardService uses when it tallies won and lost deals.
public static class DealCommercialOption
{
    public static decimal Adjustment(string status)
    {
        if (status == "closed")
            return 0.15m;
        if (status == "revoked")
            return -0.20m;
        return 0m;
    }
}
