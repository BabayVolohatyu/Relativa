namespace Relativa.Graph.DesignAudit;

public sealed class StatusDesk : IStatusDesk
{
    private readonly IStatusWeight _weights;

    public StatusDesk(IStatusWeight weights) => _weights = weights;

    public decimal StatusBonus() => _weights.Weight("closed");

    public decimal RevokeBonus() => _weights.Weight("revoked");

    public decimal OpenBonus() => _weights.Weight("open");

    public decimal PendingBonus() => _weights.Weight("pending");
}

public sealed class StageDesk : IStageDesk
{
    private readonly IStageWeight _stage;
    private readonly IClosingWeight _closing;

    public StageDesk(IStageWeight stage, IClosingWeight closing)
    {
        _stage = stage;
        _closing = closing;
    }

    public decimal StageBonus(string stage) => _stage.Weight(stage) + _closing.MonthBonus(false);

    public decimal StagePair(string stage) => _stage.Weight(stage) + _closing.MonthBonus(false);

    public decimal ProspectBonus() => _stage.Prospect() + _closing.MonthBonus(false);

    public decimal QualificationBonus() => _stage.Qualification() + _closing.MonthBonus(false);

    public decimal ProposalBonus() => _stage.Proposal() + _closing.MonthBonus(false);

    public decimal NegotiationBonus() => _stage.Negotiation() + _closing.MonthBonus(false);
}

public sealed class RiskDesk : IRiskDesk
{
    private readonly IRiskWeight _risk;
    private readonly IAccessWeight _access;

    public RiskDesk(IRiskWeight risk, IAccessWeight access)
    {
        _risk = risk;
        _access = access;
    }

    public decimal RiskBonus(string band) => _risk.Weight(band) + _access.Weight("none");

    public decimal MediumRiskBonus() => _risk.Medium() + _access.Weight("none");

    public decimal LowRiskBonus() => _risk.Low() + _access.Weight("none");

    public decimal AccessBonus(string level) => _access.Weight(level) + _risk.Weight("none");

    public decimal FullAccessBonus() => _access.Full() + _risk.Weight("none");

    public decimal OrgAccessBonus() => _access.Org() + _risk.Weight("none");
}

public sealed class QuoteDesk
{
    private readonly IStatusDesk _status;
    private readonly IStageDesk _stage;
    private readonly IRiskDesk _risk;

    public QuoteDesk(IStatusDesk status, IStageDesk stage, IRiskDesk risk)
    {
        _status = status;
        _stage = stage;
        _risk = risk;
    }

    public decimal Bundle(string stage, string band, string level) =>
        _status.StatusBonus()
        + _stage.StageBonus(stage)
        + _risk.RiskBonus(band)
        + _risk.AccessBonus(level);
}
