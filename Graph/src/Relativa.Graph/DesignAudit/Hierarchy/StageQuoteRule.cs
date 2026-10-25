namespace Relativa.Graph.DesignAudit.Hierarchy;

public class StageQuoteRule : QuoteRule
{
    public override decimal Status(string status) => 0.16m;

    public override decimal Revoked(string status) => -0.19m;

    public override decimal Open(string status) => 0.01m;

    public override decimal Pending(string status) => 0.01m;

    public override decimal Prospect(string status) => 0.03m;

    public override decimal Qualification(string status) => 0.06m;

    public override decimal Proposal(string status) => 0.09m;

    public override decimal Negotiation(string status) => 0.13m;

    public override decimal HighRisk(string status) => -0.09m;

    public override decimal MediumRisk(string status) => -0.03m;

    public override decimal LowRisk(string status) => 0.04m;
}
