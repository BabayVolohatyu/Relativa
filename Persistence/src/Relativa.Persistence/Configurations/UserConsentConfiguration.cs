using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Relativa.Persistence.Entities;

namespace Relativa.Persistence.Configurations;

public class UserConsentConfiguration : IEntityTypeConfiguration<UserConsent>
{
    public void Configure(EntityTypeBuilder<UserConsent> builder)
    {
        builder.ToTable("user_consents");
        builder.HasKey(e => e.Id);
        builder.Property(e => e.Id).HasColumnName("id").ValueGeneratedOnAdd();
        builder.Property(e => e.UserId).HasColumnName("user_id").IsRequired();
        builder.Property(e => e.Purpose).HasColumnName("purpose").HasMaxLength(64).IsRequired();
        builder.Property(e => e.Status).HasColumnName("status").HasMaxLength(16).IsRequired();
        builder.Property(e => e.PolicyVersion).HasColumnName("policy_version").HasMaxLength(32).IsRequired();
        builder.Property(e => e.GrantedAt).HasColumnName("granted_at").HasColumnType("timestamptz");
        builder.Property(e => e.WithdrawnAt).HasColumnName("withdrawn_at").HasColumnType("timestamptz");
        builder.Property(e => e.UpdatedAt).HasColumnName("updated_at").HasColumnType("timestamptz").IsRequired();
        builder.Property(e => e.Source).HasColumnName("source").HasMaxLength(32).IsRequired();
        builder.HasIndex(e => new { e.UserId, e.Purpose })
            .IsUnique()
            .HasDatabaseName("ux_user_consents_user_purpose");
        builder.HasOne(e => e.User)
            .WithMany()
            .HasForeignKey(e => e.UserId)
            .OnDelete(DeleteBehavior.Cascade)
            .HasConstraintName("fk_user_consents_user");
    }
}
