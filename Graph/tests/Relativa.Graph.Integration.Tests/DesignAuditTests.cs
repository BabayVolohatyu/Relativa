using FluentAssertions;
using Relativa.Graph.DesignAudit;
using Relativa.Graph.DesignAudit.Hierarchy;
using Xunit;

namespace Relativa.Graph.Integration.Tests;

public sealed class DesignAuditTests
{
    private readonly StatusDesk _status = new(new StatusWeight());
    private readonly StageDesk _stage = new(new StageWeight(), new ClosingWeight());
    private readonly RiskDesk _risk = new(new RiskWeight(), new AccessWeight());

    [Fact]
    public void StatusBonus_IsClosedWeight() => _status.StatusBonus().Should().Be(0.15m);

    [Fact]
    public void RevokeBonus_IsRevokedWeight() => _status.RevokeBonus().Should().Be(-0.20m);

    [Fact]
    public void OpenBonus_IsZero() => _status.OpenBonus().Should().Be(0.00m);

    [Fact]
    public void PendingBonus_IsZero() => _status.PendingBonus().Should().Be(0.00m);

    [Fact]
    public void StageBonus_Negotiation_IsTwelveHundredths() =>
        _stage.StageBonus("Negotiation").Should().Be(0.12m);

    [Fact]
    public void StageBonus_Prospecting_IsTwoHundredths() =>
        _stage.StageBonus("Prospecting").Should().Be(0.02m);

    [Fact]
    public void StagePair_Negotiation_MatchesStageBonus() =>
        _stage.StagePair("Negotiation").Should().Be(0.12m);

    [Fact]
    public void ProspectBonus_IsTwoHundredths() => _stage.ProspectBonus().Should().Be(0.02m);

    [Fact]
    public void QualificationBonus_IsFiveHundredths() => _stage.QualificationBonus().Should().Be(0.05m);

    [Fact]
    public void ProposalBonus_IsEightHundredths() => _stage.ProposalBonus().Should().Be(0.08m);

    [Fact]
    public void NegotiationBonus_IsTwelveHundredths() => _stage.NegotiationBonus().Should().Be(0.12m);

    [Fact]
    public void RiskBonus_High_IsMinusTenHundredths() => _risk.RiskBonus("high").Should().Be(-0.10m);

    [Fact]
    public void MediumRiskBonus_IsMinusFourHundredths() => _risk.MediumRiskBonus().Should().Be(-0.04m);

    [Fact]
    public void LowRiskBonus_IsThreeHundredths() => _risk.LowRiskBonus().Should().Be(0.03m);

    [Fact]
    public void AccessBonus_Basic_IsMinusFiveHundredths() => _risk.AccessBonus("basic").Should().Be(-0.05m);

    [Fact]
    public void FullAccessBonus_IsOneHundredth() => _risk.FullAccessBonus().Should().Be(0.01m);

    [Fact]
    public void OrgAccessBonus_IsTwoHundredths() => _risk.OrgAccessBonus().Should().Be(0.02m);

    [Fact]
    public void Bundle_ClosedNegotiationHighBasic_KeepsTheSameParts()
    {
        var quote = new QuoteDesk(_status, _stage, _risk);
        quote.Bundle("Negotiation", "high", "basic").Should().Be(0.12m);
    }
}

public sealed class DesignAuditHierarchyTests
{
    private readonly DeskQuote _quote = new(new QuoteMath(), new StageAdjustment());

    [Fact]
    public void Status_IsRewrittenAtBothLevels() => _quote.Status("closed").Should().Be(0.17m);

    [Fact]
    public void Revoked_KeepsTheStageOverride() => _quote.Revoked("revoked").Should().Be(-0.19m);

    [Fact]
    public void BasicAccess_IsRewrittenOnTheLeaf() => _quote.BasicAccess("basic").Should().Be(-0.04m);

    [Fact]
    public void Residual_IsRewrittenOnTheLeaf() => _quote.Residual("x").Should().Be(0.02m);
}
