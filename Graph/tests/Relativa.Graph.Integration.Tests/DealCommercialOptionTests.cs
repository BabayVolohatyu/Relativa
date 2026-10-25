using FluentAssertions;
using Relativa.Graph.Dashboard;
using Xunit;

namespace Relativa.Graph.Integration.Tests;

public sealed class DealCommercialOptionTests
{
    [Fact]
    public void Evaluate_ClosedProspectingHighBasic_AppliesClosedBonusWithoutClosingPair()
    {
        DealCommercialOption.Evaluate("closed", "Prospecting", "high", "basic", false, false)
            .Should().Be(0.06m);
    }

    [Fact]
    public void Evaluate_RevokedNegotiationMediumFull_AppliesBothCompoundRules()
    {
        DealCommercialOption.Evaluate("revoked", "Negotiation", "medium", "full", true, true)
            .Should().Be(0.00m);
    }

    [Fact]
    public void Evaluate_OpenProposalLowFullOrg_SkipsBothCompoundRules()
    {
        DealCommercialOption.Evaluate("open", "Proposal", "low", "full_org", true, false)
            .Should().Be(0.13m);
    }

    [Fact]
    public void Evaluate_ClosedNegotiationLowFullOrg_StacksClosingPairAndClosedBonus()
    {
        DealCommercialOption.Evaluate("closed", "Negotiation", "low", "full_org", true, true)
            .Should().Be(0.43m);
    }

    [Fact]
    public void Evaluate_UnknownStatusOnProspecting_AddsOnlyTheKnownDeltas()
    {
        DealCommercialOption.Evaluate("pending", "Prospecting", "low", "basic", false, false)
            .Should().Be(0.00m);
    }

    [Fact]
    public void ScoreLegacyTier_KnownTier_ReadsTheTable()
    {
        DealCommercialOption.ScoreLegacyTier(10).Should().Be(10);
    }

    [Fact]
    public void ScoreLegacyTier_UnknownTier_ReturnsSentinel()
    {
        DealCommercialOption.ScoreLegacyTier(11).Should().Be(-1);
    }
}
