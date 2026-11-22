# relativa-core

> **Deprecated as an operational description (documentation audit 2026-11-22).** The text below still says the EF model is empty and that migrations live in Core. Both statements are false. Design: [docs/sdd.md](../docs/sdd.md). Run and recovery: [docs/isd.md](../docs/isd.md).



Бізнес-API на **ASP.NET Core 10**. **Solution** у корені; **Web API** у `src/Relativa.Core/`.

## Порт

- **8082**

## Стек

- **EF Core** + **Npgsql** — `RelativaDbContext` у `Data/` (порожня модель; міграції залишаються **тут** разом із DbContext).
- OpenAPI в режимі Development.
- CORS за замовчуванням відкритий (підтягнути для production).

## Конфігурація

- `ConnectionStrings:Default` — заглушка підключення до PostgreSQL у `appsettings.json`.

## Подальша робота

- CRUD для сутностей/користувачів/угод/workspaces, ізоляція workspace, бізнес-правила БП-01–БП-06.
- **Domain events → relativa-audit** — публікація з Core після появи пайплайну подій.

## Команди

```bash
dotnet restore Relativa.Core.sln
dotnet build Relativa.Core.sln
dotnet run --project src/Relativa.Core
```

## Міграції

Зміни схеми застосовувати через EF Core міграції **у цьому** репозиторії. Репозиторій/образ **relativa-migrations** виконує ці міграції (або EF bundle, зібраний з Core) проти PostgreSQL під час деплою.
