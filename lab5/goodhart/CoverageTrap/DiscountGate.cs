namespace Relativa.Lab5.Goodhart;

public static class DiscountGate
{
    public static decimal Apply(decimal price, bool loyal)
    {
        if (price < 0)
        {
            throw new ArgumentOutOfRangeException(nameof(price));
        }

        if (loyal)
        {
            return decimal.Round(price * 0.9m, 2);
        }

        return price;
    }
}
