using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Relativa.Persistence.Entities;

namespace Relativa.Persistence.Configurations;

public class UserConsentEventConfiguration : IEntityTypeConfiguration<UserConsentEvent>
{
    public void Configure(EntityTypeBuilder<UserConsentEvent> builder)
    {
        builder.ToTable("user_consent_events");
        builder.HasKey(e => e.Id);
        builder.Property(e => e.Id).HasColumnName("id").ValueGeneratedOnAdd();
        builder.Property(e => e.UserId).HasColumnName("user_id").IsRequired();
        builder.Property(e => e.Purpose).HasColumnName("purpose").HasMaxLength(64).IsRequired();
        builder.Property(e => e.Action).HasColumnName("action").HasMaxLength(16).IsRequired();
        builder.Property(e => e.PolicyVersion).HasColumnName("policy_version").HasMaxLength(32).IsRequired();
        builder.Property(e => e.Source).HasColumnName("source").HasMaxLength(32).IsRequired();
        builder.Property(e => e.OccurredAt).HasColumnName("occurred_at").HasColumnType("timestamptz").IsRequired();
        builder.HasIndex(e => new { e.UserId, e.Purpose, e.OccurredAt })
            .HasDatabaseName("ix_user_consent_events_user_purpose");
        builder.HasOne(e => e.User)
            .WithMany()
            .HasForeignKey(e => e.UserId)
            .OnDelete(DeleteBehavior.Cascade)
            .HasConstraintName("fk_user_consent_events_user");
    }
}
