# Захист ЛР10, ЛР11, ЛР12

Гілка з усіма трьома роботами — `testing/lab12`. Команди `git` і скрипти запускай з кореня репозиторію. Тексти відкривай з цієї папки: посилання зі звітів ведуть на копії поруч.

Порядок на парі: спочатку MUST_READ уголос, потім DEFENCE, звіт лише якщо просять деталь, докази — з `evidence`.

## ЛР10. Аудит і паспорт

| Що відкрити | Файл |
|---|---|
| Проговорити | [lab10/MUST_READ_REVIEW_CHANGE.md](lab10/MUST_READ_REVIEW_CHANGE.md) |
| Хід захисту | [lab10/DEFENCE.md](lab10/DEFENCE.md) |
| Звіт | [lab10/REPORT.md](lab10/REPORT.md) |
| Лічильники git | [lab10/evidence/git-baseline.txt](lab10/evidence/git-baseline.txt) |
| Краш-тест | [lab10/evidence/crash-test.txt](lab10/evidence/crash-test.txt) |
| SDD | [docs/architecture/sdd.md](docs/architecture/sdd.md) |
| ISD | [docs/architecture/isd.md](docs/architecture/isd.md) |
| ADR-0001 | [docs/architecture/adr/ADR-0001-shared-postgresql.md](docs/architecture/adr/ADR-0001-shared-postgresql.md) |
| ADR-0002 | [docs/architecture/adr/ADR-0002-asynchronous-messaging.md](docs/architecture/adr/ADR-0002-asynchronous-messaging.md) |
| Матриця аудиторій | [docs/audience-matrix.md](docs/audience-matrix.md) |
| Регламент | [docs/maintenance.md](docs/maintenance.md) |
| Передача | [docs/handover.md](docs/handover.md) |
| Deprecated README | [docs/architecture/deprecated-service-readmes.md](docs/architecture/deprecated-service-readmes.md) |

Коміти: паспорт `80c9cac`, FAIL `22a20df`, PASS `e8f1346`. Гілка демо — `testing/lab10`.

## ЛР11. База знань і контракт

| Що відкрити | Файл |
|---|---|
| Проговорити | [lab11/MUST_READ_REVIEW_CHANGE.md](lab11/MUST_READ_REVIEW_CHANGE.md) |
| Хід захисту | [lab11/DEFENCE.md](lab11/DEFENCE.md) |
| Звіт | [lab11/REPORT.md](lab11/REPORT.md) |
| Контракт | [docs/api/openapi.yaml](docs/api/openapi.yaml) |
| Сторінка API | [docs/api/index.md](docs/api/index.md) |
| Curl | [lab11/evidence/contract-curl.txt](lab11/evidence/contract-curl.txt) |
| Swagger | [lab11/evidence/swagger-api-page.png](lab11/evidence/swagger-api-page.png), [Try it out](lab11/evidence/swagger-try-it-out.png) |
| Lint | [lab11/evidence/lint.txt](lab11/evidence/lint.txt) |
| Strict FAIL | [lab11/evidence/strict-fail.txt](lab11/evidence/strict-fail.txt), [job](lab11/evidence/ci-fail-job.png), [крок](lab11/evidence/ci-fail-strict-step.png) |
| Strict PASS | [lab11/evidence/ci-pass-strict-step.png](lab11/evidence/ci-pass-strict-step.png) |
| Протокол CI | [lab11/evidence/ci-protocol.txt](lab11/evidence/ci-protocol.txt) |
| Дати рев'ю | [lab11/evidence/review-dates.txt](lab11/evidence/review-dates.txt) |
| Граф | [lab11/evidence/knowledge-graph.png](lab11/evidence/knowledge-graph.png) |

Коміти: база `ef5774c`, FAIL `a254377`, PASS `96d2bf4`, тег `docs-v1.0`. Гілка демо — `testing/lab11`.

## ЛР12. Runbook, RFC, інцидент

| Що відкрити | Файл |
|---|---|
| Проговорити | [lab12/MUST_READ_REVIEW_CHANGE.md](lab12/MUST_READ_REVIEW_CHANGE.md) |
| Хід захисту | [lab12/DEFENCE.md](lab12/DEFENCE.md) |
| Звіт | [lab12/REPORT.md](lab12/REPORT.md) |
| Runbook | [docs/runbooks/RB-001.md](docs/runbooks/RB-001.md) |
| SLO | [docs/slo.yaml](docs/slo.yaml) |
| RFC | [docs/operations/rfc-001.md](docs/operations/rfc-001.md) |
| Вплив | [docs/operations/impact-analysis.md](docs/operations/impact-analysis.md) |
| CCB | [docs/operations/ccb-2026-11-22.md](docs/operations/ccb-2026-11-22.md) |
| Чек-лист релізу | [docs/operations/release-checklist.md](docs/operations/release-checklist.md) |
| Legacy Migration | [docs/operations/legacy-migration.md](docs/operations/legacy-migration.md) |
| Інцидент | [docs/operations/incident-2026-11-22.md](docs/operations/incident-2026-11-22.md) |
| Лог інциденту | [lab12/evidence/incident-log.txt](lab12/evidence/incident-log.txt) |
| Post-mortem | [docs/operations/postmortem-2026-11-22.md](docs/operations/postmortem-2026-11-22.md) |
| CAPA | [docs/operations/capa-2026-11-22.md](docs/operations/capa-2026-11-22.md) |
| Лог drill | [lab12/evidence/drill-log.txt](lab12/evidence/drill-log.txt) |
| План супроводу | [docs/maintenance-plan.md](docs/maintenance-plan.md) |

Коміти: пакет `c69b10e`, FAIL `0ae7615`, PASS `69e16ec`. Гілка демо — `testing/lab12`.
