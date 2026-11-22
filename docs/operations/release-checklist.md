---
owner: Babay
status: published
review_date: 2027-02-20
tags:
  - ops
---

# Release checklist, RFC-001

Go, якщо всі рядки так. Будь-яке ні — no-go, реліз зміни не закривається.

| Критерій | Стан на Approved |
|---|---|
| Збірка `Relativa.Migration` зелена | ще ні, умова CCB |
| Drill на `relativa_drill` з кодом 0 | ще ні, умова CCB |
| Міграція схеми на staging | не потрібна: схема не змінюється |
| Документація і CHANGELOG | RB-001 та ISD уже описують ціль. Рядок CHANGELOG — у коміті реалізації |
| Моніторинг | Алерти RB-001: BackupStale, PostgresVolumeMissing, MigrationExitNonZero. Prometheus немає, умова перевіряється командою |
| Runbook відкату | [RB-001](../runbooks/RB-001.md), розділ відкату: лише `DROP DATABASE relativa_drill` |
| Комунікація | Зміна стенда, окремого листа клієнту немає |

## Простежуваність

Вимога «RPO 24 години і дамп, який реально розгортається» → [RFC-001](rfc-001.md) → коміт реалізації → збірка Migration і лог drill → рядок [CHANGELOG](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab12/CHANGELOG.md) → тег git на коміті PASS → артефакт: файл у `backups/` (не в git) і код виходу скрипта.

Коміт реалізації і тег підставляються, коли зміна закрита. До того ланцюг обривається на RFC свідомо.
