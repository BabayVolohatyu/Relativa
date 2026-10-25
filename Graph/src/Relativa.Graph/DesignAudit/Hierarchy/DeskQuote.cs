namespace Relativa.Graph.DesignAudit.Hierarchy;

public sealed class DeskQuote
{
    private readonly QuoteMath _math;
    private readonly StageAdjustment _stage;

    public DeskQuote(QuoteMath math, StageAdjustment stage)
    {
        _math = math;
        _stage = stage;
    }

    public decimal Status(string status) => _math.Status(status) + _stage.Status(status);

    public decimal Revoked(string status) => _math.Revoked(status) + _stage.Revoked(status);

    public decimal Open(string status) => _math.Open(status) + _stage.Open(status);

    public decimal Pending(string status) => _math.Pending(status) + _stage.Pending(status);

    public decimal Prospect(string status) => _math.Prospect(status) + _stage.Prospect(status);

    public decimal Qualification(string status) => _math.Qualification(status) + _stage.Qualification(status);

    public decimal Proposal(string status) => _math.Proposal(status) + _stage.Proposal(status);

    public decimal Negotiation(string status) => _math.Negotiation(status) + _stage.Negotiation(status);

    public decimal HighRisk(string status) => _math.HighRisk(status) + _stage.HighRisk(status);

    public decimal MediumRisk(string status) => _math.MediumRisk(status) + _stage.MediumRisk(status);

    public decimal LowRisk(string status) => _math.LowRisk(status) + _stage.LowRisk(status);

    public decimal BasicAccess(string status) => _math.BasicAccess(status) + _stage.BasicAccess(status);

    public decimal FullAccess(string status) => _math.FullAccess(status) + _stage.FullAccess(status);

    public decimal OrgAccess(string status) => _math.OrgAccess(status) + _stage.OrgAccess(status);

    public decimal Closing(string status) => _math.Closing(status) + _stage.Closing(status);

    public decimal Stack(string status) => _math.Stack(status) + _stage.Stack(status);

    public decimal RoundTrip(string status) => _math.RoundTrip(status) + _stage.RoundTrip(status);

    public decimal Floor(string status) => _math.Floor(status) + _stage.Floor(status);

    public decimal Ceiling(string status) => _math.Ceiling(status) + _stage.Ceiling(status);

    public decimal Buffer(string status) => _math.Buffer(status) + _stage.Buffer(status);

    public decimal Residual(string status) => _math.Residual(status) + _stage.Residual(status);
}
