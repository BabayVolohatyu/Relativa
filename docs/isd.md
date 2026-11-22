# Специфікація інфраструктури (ISD)

Де і в якому порядку працює система з [sdd.md](sdd.md). Секретів тут немає: назви змінних є, значення беруться з локального `.env`, який у git не входить.

Дата специфікації: 2026-11-22.

## Топологія

Локальне розгортання — один Docker Compose на мережі `relativa_net` (bridge). Окремого хмарного середовища в репозиторії немає. Kubernetes-маніфестів на цій гілці немає.

| Середовище | Як підняти | Дані |
|---|---|---|
| dev | `docker compose up --build -d` з кореня, після `Copy-Item .env.example .env` | Том `postgres_data`. Демо-рядки кладе Migration |
| test | Той самий Compose у job GitHub Actions `.github/workflows/ci.yaml` (e2e і load). Файл `.env` job збирає сам | Том створюється на runner і знімається `docker compose down -v` |
| production | Не описаний маніфестом. Цільова відмінність: без MailHog і pgAdmin, секрет JWT не з fallback Compose, резервна копія PostgreSQL за розкладом | Див. [RTO і RPO](#rto-і-rpo) |

Відкат релізу застосунку на dev і test: повернути git на попередній коміт і знову зібрати змінений сервіс (`docker compose up --build -d <service>`). Відкат схеми автоматичної down-міграції немає. Дані повертаються лише з копії тома або з SQL-дампа. Поки дампа в репозиторії немає, відкат даних на dev — це `docker compose down -v` і повторний `up`, тобто втрата локальної бази.

## Порядок підняття

1. `postgres`, `rabbitmq`, `mailhog` стартують без залежностей. `pgadmin` чекає здоровий `postgres`.
2. `migration` чекає здоровий `postgres`, застосовує EF (`MigrateAsync`) і завершується.
3. `auth`, `core`, `graph`, `ml`, `audit` чекають здоровий `postgres`, здоровий `rabbitmq` і успішне завершення `migration`.
4. `gateway` чекає здоровий `auth`, здоровий `core` і старт контейнерів `graph`, `ml`, `audit` (`service_started`, не health).
5. `client` чекає здоровий `gateway`.

Graph не чекає ML. Обидва кроки 3 йдуть паралельно. Оцінка через `relativa.graph_ml` можлива лише коли обидва контейнери вже запущені; порядок між ними Compose не фіксує.

Здоров'я HTTP: Gateway `GET /health` на порту 8080. Перевірка в Compose для auth, core і gateway — відкритий TCP-порт, не розбір тіла `/health`.

## Змінні оточення

Імена, без значень. Локальні підстановки за замовчуванням лежать у `docker-compose.yaml` і в `.env.example`. Fallback JWT у Compose — лише для локального dev. У production його бути не може.

| Змінна | Хто читає | Навіщо |
|---|---|---|
| `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS` | postgres, auth, core, graph, ml, audit, migration | Одна база |
| `RABBITMQ_USER`, `RABBITMQ_PASS` | rabbitmq і всі видавці та споживачі | AMQP. У ML ім'я змінної пароля — `RABBITMQ_PASSWORD` |
| `JWT_SECRET`, `JWT_ISSUER`, `JWT_AUDIENCE` | auth, audit, gateway | Підпис і перевірка токена. Три значення мають збігатися |
| `SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_FROM_ADDRESS`, `SMTP_FROM_NAME`, `SMTP_USE_SSL` | auth | Листи. На dev хост — MailHog |
| `SMS_PROVIDER`, `SMS_SINK_EMAIL`, `SMS_ENDPOINT`, `SMS_AUTH_TOKEN`, `SMS_FROM` | auth | SMS. Токен не комітиться |
| `APP_FRONTEND_BASE_URL`, `SUPPORT_DEV_EMAIL` | auth | Посилання в листах |
| `CORS_ORIGIN_1`, `CORS_ORIGIN_2`, `CORS_ALLOW_ANY_ORIGIN_FOR_DEV` | gateway | Браузерні origin |
| `VITE_GATEWAY_URL`, `CLIENT_PORT` | client | Куди SPA шле API і який порт на хості |
| `PGADMIN_DEFAULT_EMAIL`, `PGADMIN_DEFAULT_PASSWORD`, `PGADMIN_PORT` | pgadmin | Лише dev |
| `MIGRATION_TRUNCATE_DB` | migration | `true` стирає дані перед міграцією. На production не вмикати |
| `ML_SCORING_RESILIENCE_*` | graph | Число спроб і таймаути RPC до ML |

## CI/CD

Файл продукту — [.github/workflows/ci.yaml](../.github/workflows/ci.yaml).

Тригери:

- `push` у гілки `release/**` і `feature/**`
- `pull_request` (`opened`, `synchronize`, `ready_for_review`) у `release/**` і `main`
- `workflow_dispatch`

Гілка `testing/lab10` цей workflow за push не запускає. Це свідомо: лабораторна гілка не є релізною.

Стадії, які блокують збірку:

| Job | Що перевіряє |
|---|---|
| `authentication-unit-tests` | `dotnet test` Authentication |
| `core-unit-tests`, `core-integration-tests` | Core |
| `messaging-tests` | Messaging |
| `audit-unit-tests`, `audit-integration-tests` | Audit |
| `graph-integration-tests` | Graph |
| `coverage-report` | Після семи тестових job. Поріг: line ≥ 80% і branch ≥ 80% на кожну збірку `Relativa.*` у звіті. Порожній звіт — теж відмова |
| `supply-chain` | `lab3/sca.ps1` (вразливості NuGet) і `gitleaks` з кодом виходу 1 |

`e2e-tests` (Playwright) і `load-tests` (NBomber, профіль smoke) запускаються лише на pull request, який не є draft. Load має `continue-on-error: true`, тому червоний load не блокує merge. E2E блокує.

Окремі файли `lab5-quality-gate.yaml`, `lab7-hotspots.yaml`, `lab8-design.yaml` — контур лабораторних вимірів, не конвеєр викладу релізу.

Локальний гачок `.githooks/pre-commit` не пускає коміт із секретом (gitleaks) і коміт C# із цикломатичною складністю методу вище 10 (lizard).

## Моніторинг

Окремого Prometheus чи Grafana в репозиторії немає. Сервіси .NET пишуть Serilog у консоль і в файл `logs/gateway-.log` (Gateway; добова ротація). Для dev достатньо `docker compose logs -f <service>` і `GET /health` на шлюзі. Ціль для production, якої в репозиторії ще немає: той самий `/health` за балансувальником і алерт, якщо TCP-перевірка шлюзу падає довше за RTO нижче.

## RTO і RPO

Цифри нижче — цілі. Поточного автоматичного резервного копіювання немає, тож ціль не виконана.

| Сховище | Що переживає рестарт контейнера | Ціль RPO | Ціль RTO | Факт на dev |
|---|---|---|---|---|
| PostgreSQL, том `postgres_data` | Так, доки не зроблено `docker compose down -v` | 24 години (щоденний дамп) | 4 години до піднятого Compose і відновленої бази | Дампа немає. Втрата тома знищує всі рядки. RPO фактично не обмежений |
| `audit_outbox` у тій самій базі | Разом із PostgreSQL | Той самий, 24 години | Той самий, 4 години | Недоставлені події переживають рестарт брокера, бо лежать у базі |
| RabbitMQ | Ні. Тома для брокера в Compose немає | Повідомлення в пам'яті брокера: 0 після перестворення контейнера | Брокер піднімається разом зі стеком, у межах тих самих 4 годин | Втрачається лише те, що вже пішло з outbox і ще не підтверджене споживачем. Повторна публікація йде з бази |
| Код і образи | Ні, образи збираються з git | Не дані | Повторна збірка `docker compose up --build` | Відкат коду — git, не реєстр образів |

Відновлення, якого треба дотримуватися, коли дамп з'явиться:

1. Підняти `postgres` і дочекатися health.
2. Залити дамп, знятий не пізніше ніж RPO тому.
3. Запустити `migration` (no-op, якщо схема дампа вже на тій самій міграції).
4. Підняти решту стека в порядку розділу [Порядок підняття](#порядок-підняття).
5. Перевірити `GET http://localhost:8080/health`.

Поки кроків 2 немає в автоматизації, чесна заява для DevOps: система на dev відновлюється з нуля міграцією і демо-даними, а не з копії клієнтських рядків.
