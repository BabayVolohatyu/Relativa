using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Relativa.Persistence.Entities;

namespace Relativa.Persistence.Configurations;

public class MarketingDispatchConfiguration : IEntityTypeConfiguration<MarketingDispatch>
{
    public void Configure(EntityTypeBuilder<MarketingDispatch> builder)
    {
        builder.ToTable("marketing_dispatches");
        builder.HasKey(e => e.Id);
        builder.Property(e => e.Id).HasColumnName("id").ValueGeneratedOnAdd();
        builder.Property(e => e.UserId).HasColumnName("user_id").IsRequired();
        builder.Property(e => e.Purpose).HasColumnName("purpose").HasMaxLength(64).IsRequired();
        builder.Property(e => e.SentAt).HasColumnName("sent_at").HasColumnType("timestamptz").IsRequired();
        builder.Property(e => e.CorrelationId).HasColumnName("correlation_id").HasMaxLength(64).IsRequired();
        builder.HasIndex(e => new { e.UserId, e.SentAt })
            .HasDatabaseName("ix_marketing_dispatches_user_sent_at");
        builder.HasOne(e => e.User)
            .WithMany()
            .HasForeignKey(e => e.UserId)
            .OnDelete(DeleteBehavior.Cascade)
            .HasConstraintName("fk_marketing_dispatches_user");
    }
}
