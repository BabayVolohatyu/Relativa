namespace Relativa.Persistence.Entities;

public class UserConsentEvent
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string Purpose { get; set; } = null!;
    public string Action { get; set; } = null!;
    public string PolicyVersion { get; set; } = null!;
    public string Source { get; set; } = null!;
    public DateTimeOffset OccurredAt { get; set; }
    public User User { get; set; } = null!;
}
