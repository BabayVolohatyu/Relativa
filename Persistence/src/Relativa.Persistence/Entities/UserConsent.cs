namespace Relativa.Persistence.Entities;

public class UserConsent
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string Purpose { get; set; } = null!;
    public string Status { get; set; } = null!;
    public string PolicyVersion { get; set; } = null!;
    public DateTimeOffset? GrantedAt { get; set; }
    public DateTimeOffset? WithdrawnAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public string Source { get; set; } = null!;
    public User User { get; set; } = null!;
}
