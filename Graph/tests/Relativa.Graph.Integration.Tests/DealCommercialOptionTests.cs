using FluentAssertions;
using Relativa.Graph.Dashboard;
using Xunit;

namespace Relativa.Graph.Integration.Tests;

public sealed class DealCommercialOptionTests
{
    [Fact]
    public void Adjustment_Closed_ReturnsWonBonus()
    {
        DealCommercialOption.Adjustment("closed").Should().Be(0.15m);
    }

    [Fact]
    public void Adjustment_Revoked_ReturnsLostPenalty()
    {
        DealCommercialOption.Adjustment("revoked").Should().Be(-0.20m);
    }

    [Fact]
    public void Adjustment_UnknownStatus_ReturnsZero()
    {
        DealCommercialOption.Adjustment("open").Should().Be(0m);
    }
}
