# Захист лабораторної роботи №11

База знань MkDocs, контракт OpenAPI, strict-конвеєр

Гілка `testing/lab11`. База `ef5774c`. FAIL `a254377`. PASS `96d2bf4`. Тег `docs-v1.0` на PASS. Звіт: `lab11/REPORT.md`. На захисті проговори вголос розділ «Що сказати» з `MUST_READ_REVIEW_CHANGE.md`. Цифри ті самі.

## 1. Мета

Поставити документацію в той самий конвеєр, що й код. Один факт має одне місце. Мертве посилання зупиняє публікацію так само, як червоний тест зупиняє реліз.

## 2. Що зроблено

Чотири рівні: README, `docs/developer/`, `docs/api/openapi.yaml`, `docs/architecture/`. SDD, ISD і два ADR переїхали з ЛР10, номери `ADR-0001` і `ADR-0002`, статус Accepted, тексти рішень не переписані. У кожної сторінки сайту є `owner`, `status`, `review_date`. Прострочена deprecated-сторінка лишилась і вказує на паспорт.

Контракт 1.0.0 описує три живі маршрути шлюзу. Сторінка API не копіює їх у таблицю: Swagger UI читає `openapi.yaml`. Spectral — нуль errors. Клієнт `sdk/client` згенерований з того самого файлу.

Конвеєр: markdownlint, Spectral, аудит дат, `mkdocs build --strict`. На FAIL крок strict упав з Exit Code 1. На PASS цей крок зелений. Deploy Pages окремо червоний, бо в репозиторії ще не увімкнене джерело GitHub Actions.

## 3. Покроково

З кореня, гілка `testing/lab11`:

```text
git log -4 --oneline
git show --stat a254377
git show --stat 96d2bf4
git show docs-v1.0:docs/api/openapi.yaml
```

`a254377` додає в `docs/developer/local-setup.md` посилання на `missing-page.md` і більше нічого. `96d2bf4` це посилання прибирає.

Локально, коли шлюз слухає 8080:

```text
curl http://localhost:8080/health
curl http://localhost:8080/api/v1/operator/digest
```

Тіла збігаються з `example` у контракті. `POST /auth/api/v1/auth/login` без Authentication дає 502 і порожнє тіло. Це записано в контракті окремо від JSON-помилки шлюзу.

Сайт локально: `mkdocs serve`, сторінка API під префіксом `/Relativa/api/`, бо `site_url` — GitHub Pages.

## 4. Питання, на яких знімають бали

Single Source of Truth. Довідка API не має власної таблиці маршрутів. Плагін читає `docs/api/openapi.yaml`. Зміна тіла відповіді робиться в цьому файлі. Наступна збірка показує вже нове тіло. Другий опис тих самих полів у Markdown розійшовся б і лишився б непоміченим.

API-first і code-first. Тут контракт написаний як файл OpenAPI за маршрутами і DTO, які вже є в коді, і з нього зібрані сторінка і C# клієнт. Code-first було б навпаки: атрибути в C# генерують yaml. Ми не генерували yaml з коду. Ми звірили yaml з кодом викликом `GET /health` і `GET /api/v1/operator/digest`.

Чому login 502 порожній. Проксі YARP сам завершує відповідь, коли кластер не піднятий. `GlobalExceptionHandler` шлюзу пише JSON лише коли виняток стався в процесі шлюзу. Для `/health` і `/digest` контракт тому описує JSON 502, для логіну — порожнє тіло.

Чому deprecated не валить CI. `check_review_dates.py` падає лише на простроченому `published` і на сторінці без паспорта. `deprecated` друкується і лишається, зі стрілкою на актуальний документ.

Чому Pages ще не відкривається. Job збірки на `96d2bf4` зелений. Job деплою отримав 404: сайт Pages у репозиторії не увімкнений. Шлях — Settings, Pages, джерело GitHub Actions, потім перезапуск deploy.
