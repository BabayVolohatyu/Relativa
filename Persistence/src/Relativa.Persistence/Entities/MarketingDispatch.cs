namespace Relativa.Persistence.Entities;

public class MarketingDispatch
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string Purpose { get; set; } = null!;
    public DateTimeOffset SentAt { get; set; }
    public string CorrelationId { get; set; } = null!;
    public User User { get; set; } = null!;
}
