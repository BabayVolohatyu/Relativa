# Changelog

## Unreleased

- RFC-001: `Migration/entrypoint.sh` відмовляється робити `DROP DATABASE`, доки не виставлено `RELATIVA_TRUNCATE_I_HAVE_A_DUMP=yes`. Дамп і drill — `ops/pg-dump.ps1` і `ops/pg-restore-drill.ps1`.

## docs-v1.0 — 2026-11-22

- База знань MkDocs: чотири рівні, паспорт SDD / ISD / ADR з ЛР10, front matter.
- Контракт OpenAPI `1.0.0`: `GET /health`, `GET /api/v1/operator/digest`, `POST /auth/api/v1/auth/login`.
- Конвеєр `.github/workflows/docs.yml`: markdownlint, Spectral, аудит `review_date`, `mkdocs build --strict`, GitHub Pages.
