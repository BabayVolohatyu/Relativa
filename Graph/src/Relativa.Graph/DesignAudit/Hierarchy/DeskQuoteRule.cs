namespace Relativa.Graph.DesignAudit.Hierarchy;

public class DeskQuoteRule : StageQuoteRule
{
    public override decimal Status(string status) => 0.17m;

    public override decimal BasicAccess(string status) => -0.04m;

    public override decimal FullAccess(string status) => 0.02m;

    public override decimal OrgAccess(string status) => 0.03m;

    public override decimal Closing(string status) => 0.08m;

    public override decimal Stack(string status) => 0.05m;

    public override decimal RoundTrip(string status) => 0.02m;

    public override decimal Floor(string status) => 0.01m;

    public override decimal Ceiling(string status) => 0.21m;

    public override decimal Buffer(string status) => 0.04m;

    public override decimal Residual(string status) => 0.02m;
}
