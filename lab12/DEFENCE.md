# Захист лабораторної роботи №12

Runbook, зміна RFC-001, інцидент на Migration

Гілка `testing/lab12`. Пакет `c69b10e`. FAIL `0ae7615`. PASS `69e16ec`. Звіт: `lab12/REPORT.md`. Перед парою проговори вголос різницю SLI, SLO і SLA і різницю двох видів CAPA. Текст — у `MUST_READ_REVIEW_CHANGE.md`.

## 1. Мета

Щоб черговий відновлював базу командами з RB-001, а не читанням `Program.cs`. Щоб RPO не вважався виконаним, доки drill не показав той самий лічильник таблиць. Щоб збій на Migration закінчився зміною процесу, а не записом «хтось забув».

## 2. Що зроблено

RB-001, три алерти, політика 3-2-1 з прямо названою дірою «немає копії поза машиною», `docs/slo.yaml` з трьома визначеннями і бюджетами 216, 432 і 432 хвилини. RFC-001 нормального класу, сім рівнів впливу, CCB погодив із умовами. Інцидент: 22 секунди зупиненого postgres і `pg_restore` на файл, якого немає. PASS додав гарду truncate і скрипти. Drill збігся: 38 таблиць.

## 3. Покроково

```text
git switch testing/lab12
git log -4 --oneline
git show --stat 0ae7615
git show --stat 69e16ec
```

Повтор гарди, без прапора дампа, з кореня:

```text
bash Migration/entrypoint.sh --truncate
```

Код виходу 1. Базу це не чіпає: відмова стоїть до `pg_isready`.

Дамп і drill, якщо контейнер `relativa-postgres` healthy:

```text
powershell -NoProfile -File ops/pg-dump.ps1
powershell -NoProfile -File ops/pg-restore-drill.ps1
```

У лозі має бути `drill_ok`. Відкат drill: `DROP DATABASE relativa_drill`. Основну базу ця команда не називає.
