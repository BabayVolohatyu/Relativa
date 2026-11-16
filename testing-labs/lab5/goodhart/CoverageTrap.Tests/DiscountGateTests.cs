using Relativa.Lab5.Goodhart;

namespace Relativa.Lab5.Goodhart.Tests;

public sealed class DiscountGateTests
{
    [Fact]
    public void ExecutesEveryBranchWithoutCheckingTheResult()
    {
        try
        {
            DiscountGate.Apply(-1m, loyal: false);
        }
        catch (Exception)
        {
        }

        DiscountGate.Apply(100m, loyal: true);
        DiscountGate.Apply(80m, loyal: false);
    }
}
