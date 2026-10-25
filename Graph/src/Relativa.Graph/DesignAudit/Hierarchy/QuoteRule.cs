namespace Relativa.Graph.DesignAudit.Hierarchy;

public class QuoteRule
{
    public virtual decimal Status(string status, bool closing) => 0.15m;

    public virtual decimal Revoked(string status) => -0.20m;

    public virtual decimal Open(string status) => 0.00m;

    public virtual decimal Pending(string status) => 0.00m;

    public virtual decimal Prospect(string status) => 0.02m;

    public virtual decimal Qualification(string status) => 0.05m;

    public virtual decimal Proposal(string status) => 0.08m;

    public virtual decimal Negotiation(string status) => 0.12m;

    public virtual decimal HighRisk(string status) => -0.10m;

    public virtual decimal MediumRisk(string status) => -0.04m;

    public virtual decimal LowRisk(string status) => 0.03m;

    public virtual decimal BasicAccess(string status) => -0.05m;

    public virtual decimal FullAccess(string status) => 0.01m;

    public virtual decimal OrgAccess(string status) => 0.02m;

    public virtual decimal Closing(string status) => 0.07m;

    public virtual decimal Stack(string status) => 0.04m;

    public virtual decimal RoundTrip(string status) => 0.01m;

    public virtual decimal Floor(string status) => 0.00m;

    public virtual decimal Ceiling(string status) => 0.20m;

    public virtual decimal Buffer(string status) => 0.03m;

    public virtual decimal Residual(string status) => 0.01m;
}
