using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Relativa.Migration.Migrations
{
    /// <inheritdoc />
    public partial class AddPrivacyEngineering : Microsoft.EntityFrameworkCore.Migrations.Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "anonymized_at",
                table: "users",
                type: "timestamptz",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "marketing_dispatches",
                columns: table => new
                {
                    id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    user_id = table.Column<int>(type: "integer", nullable: false),
                    purpose = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    sent_at = table.Column<DateTimeOffset>(type: "timestamptz", nullable: false),
                    correlation_id = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_marketing_dispatches", x => x.id);
                    table.ForeignKey(
                        name: "fk_marketing_dispatches_user",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "user_consent_events",
                columns: table => new
                {
                    id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    user_id = table.Column<int>(type: "integer", nullable: false),
                    purpose = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    action = table.Column<string>(type: "character varying(16)", maxLength: 16, nullable: false),
                    policy_version = table.Column<string>(type: "character varying(32)", maxLength: 32, nullable: false),
                    source = table.Column<string>(type: "character varying(32)", maxLength: 32, nullable: false),
                    occurred_at = table.Column<DateTimeOffset>(type: "timestamptz", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user_consent_events", x => x.id);
                    table.ForeignKey(
                        name: "fk_user_consent_events_user",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "user_consents",
                columns: table => new
                {
                    id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    user_id = table.Column<int>(type: "integer", nullable: false),
                    purpose = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    status = table.Column<string>(type: "character varying(16)", maxLength: 16, nullable: false),
                    policy_version = table.Column<string>(type: "character varying(32)", maxLength: 32, nullable: false),
                    granted_at = table.Column<DateTimeOffset>(type: "timestamptz", nullable: true),
                    withdrawn_at = table.Column<DateTimeOffset>(type: "timestamptz", nullable: true),
                    updated_at = table.Column<DateTimeOffset>(type: "timestamptz", nullable: false),
                    source = table.Column<string>(type: "character varying(32)", maxLength: 32, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user_consents", x => x.id);
                    table.ForeignKey(
                        name: "fk_user_consents_user",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_marketing_dispatches_user_sent_at",
                table: "marketing_dispatches",
                columns: new[] { "user_id", "sent_at" });

            migrationBuilder.CreateIndex(
                name: "ix_user_consent_events_user_purpose",
                table: "user_consent_events",
                columns: new[] { "user_id", "purpose", "occurred_at" });

            migrationBuilder.CreateIndex(
                name: "ux_user_consents_user_purpose",
                table: "user_consents",
                columns: new[] { "user_id", "purpose" },
                unique: true);

            var hash = BCrypt.Net.BCrypt.HashPassword("synthetic-password-not-real");
            migrationBuilder.Sql("""
                INSERT INTO users (id, first_name, last_name, email, phone, password, created_at, is_archived, email_verified, date_of_birth)
                SELECT 91001, 'Ada', 'Lovelace', 'ada.lovelace@example.test', '+15555550123', 'PASSWORD_HASH', NOW(), FALSE, TRUE, DATE '1990-01-01'
                WHERE NOT EXISTS (
                    SELECT 1 FROM users WHERE id = 91001 OR (email = 'ada.lovelace@example.test' AND is_archived = FALSE));

                INSERT INTO users (id, first_name, last_name, email, password, created_at, is_archived, email_verified)
                SELECT 91002, 'Grace', 'Hopper', 'grace.hopper@example.test', 'PASSWORD_HASH', NOW(), FALSE, TRUE
                WHERE NOT EXISTS (
                    SELECT 1 FROM users WHERE id = 91002 OR (email = 'grace.hopper@example.test' AND is_archived = FALSE));

                SELECT setval(pg_get_serial_sequence('users', 'id'), GREATEST((SELECT MAX(id) FROM users), 91002));

                INSERT INTO user_settings (user_id, locale)
                SELECT 91001, 'uk'
                WHERE EXISTS (SELECT 1 FROM users WHERE id = 91001)
                  AND NOT EXISTS (SELECT 1 FROM user_settings WHERE user_id = 91001);

                INSERT INTO user_emails (user_id, address, is_verified, source, created_at)
                SELECT 91001, 'ada.alias@example.test', TRUE, 'manual', NOW()
                WHERE EXISTS (SELECT 1 FROM users WHERE id = 91001)
                  AND NOT EXISTS (SELECT 1 FROM user_emails WHERE address = 'ada.alias@example.test');

                INSERT INTO user_external_logins (user_id, provider, subject, created_at)
                SELECT 91001, 'google', 'synthetic-subject-ada', NOW()
                WHERE EXISTS (SELECT 1 FROM users WHERE id = 91001)
                  AND NOT EXISTS (
                    SELECT 1 FROM user_external_logins WHERE provider = 'google' AND subject = 'synthetic-subject-ada');

                INSERT INTO user_audit_log (id, action, changed_by, field_name, new_value, changed_at, target_user_id)
                SELECT gen_random_uuid(), 'user_profile_updated', 91001, 'first_name', '{"firstName":"Ada"}'::jsonb, NOW(), 91001
                WHERE EXISTS (SELECT 1 FROM users WHERE id = 91001)
                  AND NOT EXISTS (
                    SELECT 1 FROM user_audit_log WHERE target_user_id = 91001 AND action = 'user_profile_updated');
                """.Replace("PASSWORD_HASH", hash, StringComparison.Ordinal));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("""
                DELETE FROM user_audit_log WHERE target_user_id IN (91001, 91002) OR changed_by IN (91001, 91002);
                DELETE FROM users WHERE id IN (91001, 91002);
                """);

            migrationBuilder.DropTable(
                name: "marketing_dispatches");

            migrationBuilder.DropTable(
                name: "user_consent_events");

            migrationBuilder.DropTable(
                name: "user_consents");

            migrationBuilder.DropColumn(
                name: "anonymized_at",
                table: "users");
        }
    }
}
