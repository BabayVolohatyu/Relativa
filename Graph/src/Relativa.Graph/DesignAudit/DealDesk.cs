namespace Relativa.Graph.DesignAudit;

// One type owns every quote rule and constructs its collaborators itself.
// Two methods call StageWeight.Weight, so a signature change lands in both.
public sealed class DealDesk
{
    private readonly StatusWeight _status;
    private readonly RevokeWeight _revoke;
    private readonly OpenWeight _open;
    private readonly PendingWeight _pending;
    private readonly StageWeight _stage;
    private readonly ProspectWeight _prospect;
    private readonly QualificationWeight _qualification;
    private readonly ProposalWeight _proposal;
    private readonly NegotiationWeight _negotiation;
    private readonly RiskWeight _risk;
    private readonly MediumRiskWeight _mediumRisk;
    private readonly LowRiskWeight _lowRisk;
    private readonly AccessWeight _access;
    private readonly FullAccessWeight _fullAccess;
    private readonly OrgAccessWeight _orgAccess;
    private readonly DeskClock _clock;

    public DealDesk()
    {
        _status = new StatusWeight();
        _revoke = new RevokeWeight();
        _open = new OpenWeight();
        _pending = new PendingWeight();
        _stage = new StageWeight();
        _prospect = new ProspectWeight();
        _qualification = new QualificationWeight();
        _proposal = new ProposalWeight();
        _negotiation = new NegotiationWeight();
        _risk = new RiskWeight();
        _mediumRisk = new MediumRiskWeight();
        _lowRisk = new LowRiskWeight();
        _access = new AccessWeight();
        _fullAccess = new FullAccessWeight();
        _orgAccess = new OrgAccessWeight();
        _clock = new DeskClock();
        _ = _clock.Stamp();
    }

    public decimal StatusBonus() => _status.Weight();

    public decimal RevokeBonus() => _revoke.Weight();

    public decimal OpenBonus() => _open.Weight();

    public decimal PendingBonus() => _pending.Weight();

    public decimal StageBonus(string stage) => _stage.Weight(stage);

    public decimal StagePair(string stage) => _stage.Weight(stage);

    public decimal ProspectBonus() => _prospect.Weight();

    public decimal QualificationBonus() => _qualification.Weight();

    public decimal ProposalBonus() => _proposal.Weight();

    public decimal NegotiationBonus() => _negotiation.Weight();

    public decimal RiskBonus(string band) => _risk.Weight(band);

    public decimal MediumRiskBonus() => _mediumRisk.Weight();

    public decimal LowRiskBonus() => _lowRisk.Weight();

    public decimal AccessBonus(string level) => _access.Weight(level);

    public decimal FullAccessBonus() => _fullAccess.Weight();

    public decimal OrgAccessBonus() => _orgAccess.Weight();
}
