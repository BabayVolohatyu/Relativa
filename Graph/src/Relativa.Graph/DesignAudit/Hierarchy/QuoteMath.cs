namespace Relativa.Graph.DesignAudit.Hierarchy;

public sealed class QuoteMath
{
    public decimal Status(string status) => 0.15m;

    public decimal Revoked(string status) => -0.20m;

    public decimal Open(string status) => 0.00m;

    public decimal Pending(string status) => 0.00m;

    public decimal Prospect(string status) => 0.02m;

    public decimal Qualification(string status) => 0.05m;

    public decimal Proposal(string status) => 0.08m;

    public decimal Negotiation(string status) => 0.12m;

    public decimal HighRisk(string status) => -0.10m;

    public decimal MediumRisk(string status) => -0.04m;

    public decimal LowRisk(string status) => 0.03m;

    public decimal BasicAccess(string status) => -0.05m;

    public decimal FullAccess(string status) => 0.01m;

    public decimal OrgAccess(string status) => 0.02m;

    public decimal Closing(string status) => 0.07m;

    public decimal Stack(string status) => 0.04m;

    public decimal RoundTrip(string status) => 0.01m;

    public decimal Floor(string status) => 0.00m;

    public decimal Ceiling(string status) => 0.20m;

    public decimal Buffer(string status) => 0.03m;

    public decimal Residual(string status) => 0.01m;
}
