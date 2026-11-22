---
owner: Babay
status: published
review_date: 2027-05-21
tags:
  - architecture
---

# Legacy: Relativa.Migration

Компонент обраний за аудитом ЛР10: на `Migration/` 61 коміт і один README, який досі описує `entrypoint.sh` як `exit 0` і міграції, що «лишаються в Core». Код цього не робить. README позначений deprecated і вказує на SDD та ISD. Цей файл збирає те, що видно з коду.

## Граф залежностей

```mermaid
flowchart LR
  compose[docker compose]
  entry[entrypoint.sh]
  program[Program.cs MigrateAsync]
  ef[MigrationDbContext]
  persistence[Relativa.Persistence]
  pg[(PostgreSQL DB_NAME)]
  auth[Authentication]
  core[Core]
  graph[Graph]
  ml[ML]
  audit[Audit]
  compose --> entry --> program --> ef --> persistence
  program --> pg
  auth --> compose
  core --> compose
  graph --> compose
  ml --> compose
  audit --> compose
```

Хто викликає компонент: лише Compose. Сервіси Auth, Core, Graph, ML і Audit не викликають Migration по HTTP. Вони чекають, поки контейнер `migration` завершиться з кодом 0 (`depends_on.condition: service_completed_successfully`). Кого викликає він: PostgreSQL через EF Core `Database.MigrateAsync`. Чергу RabbitMQ цей процес не чіпає.

## Схема і конфігурація

`MigrationDbContext` тримає `DbSet` сутностей Persistence: користувачі, організації, робочі простори, EAV-сутності, аудит. Збірка міграцій — `Relativa.Migration`, не Core. Рядок підключення — `ConnectionStrings:Default` або змінна `ConnectionStrings__Default`.

`entrypoint.sh` читає `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS`. Якщо передано `--truncate` або `MIGRATION_TRUNCATE_DB=true`, скрипт робить `DROP DATABASE` і `CREATE DATABASE` для `DB_NAME`, потім запускає `dotnet Relativa.Migration.dll`.

## Ключові місця

| Місце | Призначення | Довіра |
|---|---|---|
| `Program.cs`, `MigrateAsync` | Застосувати міграції EF і завершитися | verified, читання коду |
| `entrypoint.sh`, гілка truncate | Знищити базу `DB_NAME` до міграції | verified, читання коду |
| `Relativa.Migration.csproj` | Посилання на `Relativa.Persistence` | verified, csproj |
| README каже `exit 0` і міграції в Core | Суперечить коду | verified, порівняння з README |
| Повний перелік таблиць outbox у живому postgres | Лежить у знімку EF, не звірявся командою `\dt` до drill | assumed, до першого успішного drill |

## Реєстр боргу

| ID | Тип | Наслідок |
|---|---|---|
| MIG-D1 | documentation | Черговий за README вирішить, що контейнер нічого не робить (`exit 0`) і піде шукати міграції в Core |
| MIG-D2 | architecture | `DROP DATABASE` доступний прапором без перевірки, що дамп існує. Одна змінна оточення знищує єдину базу ADR-0001 |
| MIG-D3 | test | Немає автоматичного прогону, який доводить, що дамп цієї схеми відновлюється |
| MIG-D4 | code | Відкату міграції вниз немає. Помилкова міграція лікується дампом, якого немає |
