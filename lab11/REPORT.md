# Лабораторна робота №11

Documentation as Code: база знань, OpenAPI і strict-конвеєр

Об'єкт — Relativa, гілка `testing/lab11`, від `testing/lab10` (`9af82e5`). Паспорт ЛР10 переїхав у `docs/architecture/` і не дублюється в README. Дата зрізу — 2026-11-22.

Коміти досліду: база `ef5774c`, FAIL `a254377`, PASS `96d2bf4`. Тег знімка документації — `docs-v1.0` на `96d2bf4`. Протокол конвеєра — [evidence/ci-protocol.txt](evidence/ci-protocol.txt).

## Завдання 1. Піраміда

Кожен факт має одне місце. README лишається відповіддю «що це і як запустити». Сайт не переписує Quick Start.

```text
README.md                         рівень 1. Що це і як запустити
docs/developer/                   рівень 2. Як долучитися до розробки
docs/api/openapi.yaml             рівень 3. Як інтегруватися. Сторінка лише рендерить цей файл
docs/architecture/                рівень 4. Чому система влаштована так
  sdd.md
  isd.md
  adr/ADR-0001-shared-postgresql.md
  adr/ADR-0002-asynchronous-messaging.md
```

`docs/ai-guides/` і `docs/runbooks/` у сайт не входять (`exclude_docs` у `mkdocs.yml`). Інакше вийшла б друга архітектурна розповідь поруч із SDD.

MkDocs Material, мова `uk`. Плагіни: `search`, `meta` (читає front matter), `mermaid2` (C4 з паспорта), `git-revision-date-localized` (дата останнього коміту сторінки, локаль `uk`), `swagger-ui-tag`. Навігація — чотири розділи в `mkdocs.yml`. Збірка `mkdocs build --strict` локально проходить. Посилання на файли поза `docs/` (README, DATABASE, ci.yaml) ведуть на GitHub, бо strict не вважає їх сторінками сайту. Якорі українських заголовків у перевірку не входять (`anchors: ignore`): мертве посилання на файл strict ловить, а транслітерацію якоря — ні.

Паспорти. У кожного Markdown сайту є `owner`, `status`, `review_date`.

| Файл | owner | status | review_date |
|---|---|---|---|
| `docs/architecture/sdd.md` | Babay | published | 2027-05-21 |
| `docs/api/index.md` | Babay | published | 2027-02-20 |
| `docs/architecture/deprecated-service-readmes.md` | Babay | deprecated | 2026-04-08 |

Архітектурний цикл — 180 днів, операційний — 90. Застаріла сторінка не видалена: вона deprecated і веде на SDD та ISD. `review_date` 2026-04-08 навмисно в минулому, щоб аудит мав що показати.

`.github/CODEOWNERS` призначає `@BabayVolohatyu` на `/docs/`. Файл просить рев'ю власника. Злиття без нього блокує захист гілки «require review from code owners», не сам файл.

ADR. Номери `ADR-0001` і `ADR-0002`, статус Accepted, записи не переписані. Наступне рішення — новий файл, старому ставиться Superseded. Це те саме правило, що в ЛР10, тепер у канонічних іменах.

Граф. Корінь репозиторію — сховище Obsidian (`.obsidian/`). Wikilinks з `docs/architecture/index.md` і `docs/developer/index.md` з'єднують SDD, ISD, обидва ADR, API і розділ розробника. `lab11/build_graph.py` пройшов ті самі посилання: 15 сторінок, 43 ребра, ізольованих немає. Рисунок — [evidence/knowledge-graph.png](evidence/knowledge-graph.png).

## Завдання 2. Контракт

Файл `docs/api/openapi.yaml`, OpenAPI 3.0.3, `info.version` `1.0.0`. Три маршрути, які є в коді шлюзу:

| Метод і шлях | Звідки в коді | Жива відповідь 2026-11-22 |
|---|---|---|
| `GET /health` | `Program.cs`, анонімний | 200 `{"status":"ok","service":"relativa-gateway"}` |
| `GET /api/v1/operator/digest` | `OperatorDigestEndpoints`, маршрут з краш-тесту ЛР10 | 200, `kind=operator-digest`, три поля в `includes`, чисел угод немає |
| `POST /auth/api/v1/auth/login` | YARP, префікс `/auth` знімається, політика Anonymous | без контейнера Authentication — 502 і порожнє тіло |

Схема `Error` (`status`, `title`, `detail`) спільна для 400 і 401 логіну і для 502 процесів `/health` і `/digest`. Ці 502 пише `GlobalExceptionHandler` шлюзу. Логін інший: коли кластер Authentication не відповідає, YARP віддає 502 з `Content-Length: 0` і до обробника винятків не доходить. Контракт це так і описує. 400 (`Validation Failed`, `Email is required.`) і 401 (`Invalid email or password.`) взято з `LoginRequestValidator` і `GlobalExceptionHandler` сервісу Authentication. Живий виклик цих двох кодів не робився: процес Authentication не був піднятий. Розбіжності з тим, що вдалося викликати, немає. Лог — [evidence/contract-curl.txt](evidence/contract-curl.txt).

Сторінка `docs/api/index.md` не містить таблиці маршрутів. У ній один тег `<swagger-ui src="openapi.yaml"/>`. Версія на сторінці і в довідці — це `info.version` того самого файлу. Окремої копії для сайту немає.

Swagger UI на зібраному сайті, Try it out для `GET /health`: код 200, тіло `status=ok`, `service=relativa-gateway`. Знімки — [evidence/swagger-api-page.png](evidence/swagger-api-page.png), [evidence/swagger-try-it-out.png](evidence/swagger-try-it-out.png). Для виклику з браузера процес шлюзу був запущений з `Cors__AllowAnyOriginForDev=true`. У закоміченому `appsettings.json` цей прапор `false`, дозволені лише `localhost:5173` і `localhost:3000`.

SDK:

```text
openapi-generator-cli generate -i docs/api/openapi.yaml -g csharp -o sdk/client
```

Пакет `Relativa.Gateway.Client`, шаблон генератора зібраний під `net8.0`. Методи `GetHealthAsync`, `GetOperatorDigestAsync`, `LoginAsync`. Каталог перезаписується генератором, правити його руками не треба (`sdk/client/GENERATED-FROM.txt`). Гачок коміту пропускає `sdk/client`: згенеровані `Read` у конвертерах мають CCN вище 10. Поріг лишається на рукописному C#.

Spectral, правила в `.spectral.yaml`: кожна операція має description, кожна схема має example, тіло 4xx/5xx, якщо воно є, посилається на `#/components/schemas/Error`. Лог [evidence/lint.txt](evidence/lint.txt): markdownlint 0 errors на 17 файлах, Spectral — `No results with a severity of 'error' found!`. Вимкнені `info-contact` і теги: у контракті три маршрути одного шлюзу, контакту в `info` немає. `MD060` і `MD034` вимкнені в `.markdownlint-cli2.jsonc`, бо таблиці паспорта компактні, а в онбордингу є голі URL. Це стиль, не зламана розмітка.

## Завдання 3. Конвеєр

`.github/workflows/docs.yml`. На push у `testing/lab11` і `main` і на pull request: checkout з повною історією, Python 3.12, Node 20, `mkdocs-material` з `docs/requirements.txt`, `markdownlint-cli2`, Spectral, `lab11/check_review_dates.py`, `mkdocs build --strict`, артефакт Pages. Деплой лише з push у `testing/lab11`.

Краш-тест. У `docs/developer/local-setup.md` додано посилання на `missing-page.md`. Локальна strict-збірка: Exit Code 1, одне попередження, текст у [evidence/strict-fail.txt](evidence/strict-fail.txt). Коміт `a254377`. Job [Lint and strict build](https://github.com/BabayVolohatyu/Relativa/actions/runs/45066940593) червоний, крок Strict MkDocs build упав, анотація `Process completed with exit code 1.` Знімки — [evidence/ci-fail-job.png](evidence/ci-fail-job.png), [evidence/ci-fail-strict-step.png](evidence/ci-fail-strict-step.png). markdownlint, Spectral і аудит дат на цьому прогоні зелені: зупинила саме strict-збірка.

Відновлення. Посилання прибрано. Коміт `96d2bf4`. Той самий job зелений за 33 секунди, включно зі strict-збіркою і вивантаженням артефакта: [evidence/ci-pass-strict-step.png](evidence/ci-pass-strict-step.png), прогін [45067220777](https://github.com/BabayVolohatyu/Relativa/actions/runs/45067220777).

Публікація. Job Deploy GitHub Pages на цьому прогоні червоний: `Failed to create deployment (status: 404)`. Текст анотації просить увімкнути Pages: [налаштування репозиторію](https://github.com/BabayVolohatyu/Relativa/settings/pages), джерело — GitHub Actions. `gh` на цій машині не авторизований, тож увімкнути сайт звідси не вийшло. Після увімкнення достатньо перезапустити впалий deploy. Адреса, на яку зібраний `site_url`, — `https://babayvolohatyu.github.io/Relativa/`. Поки Pages вимкнений, ця адреса не віддає сайт.

Супровід. `lab11/check_review_dates.py` порівнює `review_date` з сьогодні. Прострочений `published` дає код 1. Прострочений `deprecated` друкується і не валить крок. На 2026-11-22 прострочений лише `architecture/deprecated-service-readmes.md`. Лог — [evidence/review-dates.txt](evidence/review-dates.txt).

Чек-лист `docs-or-don't-merge` лежить у кореневому `CONTRIBUTING.md` і в `docs/developer/contributing.md`. Якщо речення розійдуться, правий текст — файл у `docs/`, бо його збирає сайт. Таблиця тих самих перевірок є в README, розділ Definition of Done.

Тег `docs-v1.0` вказує на `96d2bf4`. Рядок про цей знімок — у `CHANGELOG.md`.
