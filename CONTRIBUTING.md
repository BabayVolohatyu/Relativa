# Як долучитися

Єдиний розгорнутий чек-лист зібраного сайту: [docs/developer/contributing.md](docs/developer/contributing.md). Нижче той самий список, щоб GitHub відкривав його з кореня.

## docs-or-don't-merge

Pull request, який змінює публічну поведінку, не зливається, доки не оновлені:

1. Сторінка в `docs/`, яка цю поведінку описує: [SDD](docs/architecture/sdd.md) для маршруту, [ISD](docs/architecture/isd.md) для порядку контейнерів.
2. [docs/api/openapi.yaml](docs/api/openapi.yaml), якщо змінився HTTP-шлях або тіло відповіді. Довідка MkDocs рендериться з цього файлу.
3. [CHANGELOG.md](CHANGELOG.md).

Перед злиттям:

- `markdownlint-cli2`
- `spectral lint docs/api/openapi.yaml` — нуль errors
- `python lab11/check_review_dates.py`
- `mkdocs build --strict`

Нове архітектурне рішення — новий файл `ADR-000N`. Запис зі статусом Accepted не переписується.
