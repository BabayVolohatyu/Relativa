---
owner: Babay
status: published
review_date: 2027-02-20
tags:
  - ops
---

# Release checklist, RFC-001

Go, якщо всі рядки так. Будь-яке ні — no-go, реліз зміни не закривається.

| Критерій | Стан після drill |
|---|---|
| Збірка `Relativa.Migration` | C# не змінювався. Змінено `entrypoint.sh`. Гарда перевірена: `--truncate` без прапора дампа завершився кодом 1 |
| Drill на `relativa_drill` з кодом 0 | так, `drill_ok tables=38` |
| Міграція схеми на staging | не потрібна: схема не змінюється |
| Документація і CHANGELOG | RB-001, ISD, рядок CHANGELOG в цьому коміті |
| Моніторинг | `ops/check-backup-age.ps1` на свіжому дампі дає код 0, на порожньому каталозі — код 1 (BackupStale) |
| Runbook відкату | [RB-001](../runbooks/RB-001.md): `DROP DATABASE relativa_drill` |
| Комунікація | Зміна стенда, окремого листа клієнту немає |

## Простежуваність

Вимога «RPO 24 години і дамп, який реально розгортається» → [RFC-001](rfc-001.md) → коміт PASS цієї гілки → лог `lab12/evidence/drill-log.txt` → рядок [CHANGELOG](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab12/CHANGELOG.md) → тег не ставився: зміна стенда, не реліз продукту → артефакт дампа лишається в `backups/` і в git не входить.
