---
owner: Babay
status: published
review_date: 2027-02-20
tags:
  - ops
---

# Як долучитися

Той самий чек-лист, що й у кореневому [CONTRIBUTING.md](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab11/CONTRIBUTING.md). Якщо речення розійдуться, правий текст — цей файл: його збирає сайт.

## docs-or-don't-merge

Pull request, який змінює публічну поведінку, не зливається, доки не оновлені всі три джерела:

1. Сторінка в `docs/`, яка цю поведінку описує. Новий маршрут шлюзу — [SDD](../architecture/sdd.md). Новий порядок контейнерів — [ISD](../architecture/isd.md).
2. [Контракт OpenAPI](../api/openapi.yaml), якщо змінився HTTP-відповідь або шлях. Довідка в розділі API рендериться з цього файлу і окремо не переписується.
3. [CHANGELOG.md](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab11/CHANGELOG.md) — рядок про зміну.

Перед злиттям локально:

- `markdownlint-cli2`
- `spectral lint docs/api/openapi.yaml` — нуль errors
- `python lab11/check_review_dates.py` — прострочена сторінка зі статусом `published` зупиняє перевірку
- `mkdocs build --strict` — мертве посилання, сторінка поза `nav` і зламана розмітка дають код виходу 1

Нове архітектурне рішення — новий файл `ADR-000N`. Старий ADR не редагується. Йому ставлять статус `Superseded` і посилання на новий номер.
