namespace Relativa.Graph.DesignAudit;

public interface IStatusWeight
{
    decimal Weight(string kind);
}

public interface IStageWeight
{
    decimal Weight(string stage);

    decimal Prospect();

    decimal Qualification();

    decimal Proposal();

    decimal Negotiation();
}

public interface IClosingWeight
{
    decimal MonthBonus(bool closingThisMonth);
}

public interface IRiskWeight
{
    decimal Weight(string band);

    decimal Medium();

    decimal Low();
}

public interface IAccessWeight
{
    decimal Weight(string level);

    decimal Full();

    decimal Org();
}

public interface IStatusDesk
{
    decimal StatusBonus();

    decimal RevokeBonus();

    decimal OpenBonus();

    decimal PendingBonus();
}

public interface IStageDesk
{
    decimal StageBonus(string stage);

    decimal StagePair(string stage);

    decimal ProspectBonus();

    decimal QualificationBonus();

    decimal ProposalBonus();

    decimal NegotiationBonus();
}

public interface IRiskDesk
{
    decimal RiskBonus(string band);

    decimal MediumRiskBonus();

    decimal LowRiskBonus();

    decimal AccessBonus(string level);

    decimal FullAccessBonus();

    decimal OrgAccessBonus();
}
