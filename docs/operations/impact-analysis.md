---
owner: Babay
status: published
review_date: 2027-02-20
tags:
  - ops
---

# Оцінка впливу RFC-001

Сім рівнів. Артефакти названі файлами, які зміна чіпає або свідомо не чіпає.

| Рівень | Що зачеплено |
|---|---|
| Вимоги | Відновлення після втрати тома. README Quick Start не змінює команди запуску. Поведінка `GET /health` і `GET /api/v1/operator/digest` не змінюється |
| Архітектура | Новий контейнер не з'являється. ADR-0001 лишається Accepted: база одна. Новий ADR не потрібен, бо дамп не міняє межу сервісів |
| Код | `ops/pg-dump.ps1`, `ops/pg-restore-drill.ps1`, `Migration/entrypoint.sh`, рядок `backups/` у `.gitignore` |
| API | Контракт `docs/api/openapi.yaml` не змінюється. Клас зміни API: немає. Breaking немає, міграційний гайд для клієнтів не потрібен |
| Дані | Схема не міняється. Drill створює і видаляє лише базу `relativa_drill`. Down-міграції EF як не було, так і немає. Відкат даних — дамп, не `Migrate` назад |
| Тести | Обов'язковий набір: `dotnet build Migration/src/Relativa.Migration/Relativa.Migration.csproj` і прогін drill з кодом 0. Повний `dotnet test` стека не потрібен: C# шлюзу і Core не змінюються |
| Документи | RB-001, розділ відновлення в ISD, рядок CHANGELOG, `docs/slo.yaml` уже описує індикатор `migration-completion`. Це той самий docs-or-don't-merge з ЛР11 |

## Risk Exposure

Шкала 1–5. Ймовірність збою drill на окремій базі — 2. Наслідок, якщо гарда truncate не спрацює і хтось знесе основну базу — 5. Добуток 10 з 25. План відкату: drill знімається командою `DROP DATABASE relativa_drill` з RB-001. Гарда знімається `git revert` коміту entrypoint. Основну базу скрипти не видаляють.
