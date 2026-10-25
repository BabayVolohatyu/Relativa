using FluentAssertions;
using Relativa.Graph.DesignAudit;
using Xunit;

namespace Relativa.Graph.Integration.Tests;

public sealed class DesignAuditTests
{
    private readonly DealDesk _desk = new();

    [Fact]
    public void StatusBonus_IsClosedWeight() => _desk.StatusBonus().Should().Be(0.15m);

    [Fact]
    public void RevokeBonus_IsRevokedWeight() => _desk.RevokeBonus().Should().Be(-0.20m);

    [Fact]
    public void OpenBonus_IsZero() => _desk.OpenBonus().Should().Be(0.00m);

    [Fact]
    public void PendingBonus_IsZero() => _desk.PendingBonus().Should().Be(0.00m);

    [Fact]
    public void StageBonus_Negotiation_IsTwelveHundredths() =>
        _desk.StageBonus("Negotiation").Should().Be(0.12m);

    [Fact]
    public void StageBonus_Prospecting_IsTwoHundredths() =>
        _desk.StageBonus("Prospecting").Should().Be(0.02m);

    [Fact]
    public void StagePair_Negotiation_MatchesStageBonus() =>
        _desk.StagePair("Negotiation").Should().Be(0.12m);

    [Fact]
    public void ProspectBonus_IsTwoHundredths() => _desk.ProspectBonus().Should().Be(0.02m);

    [Fact]
    public void QualificationBonus_IsFiveHundredths() => _desk.QualificationBonus().Should().Be(0.05m);

    [Fact]
    public void ProposalBonus_IsEightHundredths() => _desk.ProposalBonus().Should().Be(0.08m);

    [Fact]
    public void NegotiationBonus_IsTwelveHundredths() => _desk.NegotiationBonus().Should().Be(0.12m);

    [Fact]
    public void RiskBonus_High_IsMinusTenHundredths() => _desk.RiskBonus("high").Should().Be(-0.10m);

    [Fact]
    public void MediumRiskBonus_IsMinusFourHundredths() => _desk.MediumRiskBonus().Should().Be(-0.04m);

    [Fact]
    public void LowRiskBonus_IsThreeHundredths() => _desk.LowRiskBonus().Should().Be(0.03m);

    [Fact]
    public void AccessBonus_Basic_IsMinusFiveHundredths() => _desk.AccessBonus("basic").Should().Be(-0.05m);

    [Fact]
    public void FullAccessBonus_IsOneHundredth() => _desk.FullAccessBonus().Should().Be(0.01m);

    [Fact]
    public void OrgAccessBonus_IsTwoHundredths() => _desk.OrgAccessBonus().Should().Be(0.02m);
}
