# Лабораторна робота №10

Інженерний аудит документації, архітектурний паспорт (SDD, ISD, ADR) і передача знань

Об'єкт — Relativa, гілка `testing/lab10`, відгалужена від `lab9` (`5b07227`, 2026-10-25). Звіти ЛР2–ЛР9 на цій лінії лежать у каталогах `lab2/` … `lab9/` у корені, не в `testing-labs/`. Дата зрізу віку документів: 2026-11-22. Сирий лог Git — [evidence/git-baseline.txt](evidence/git-baseline.txt). Протокол краш-тесту — [evidence/crash-test.txt](evidence/crash-test.txt).

Вік = 2026-11-22 мінус дата `git log -1 --format=%cs -- <файл>`. Поріг підозри — 90 днів, поріг «ймовірно застарілий» — 180 днів. Вікно доступу — коміти з `--since=2026-10-23`. Окремого чату команди і вивантаження трекера в репозиторії немає, тож «свідчення використання» — це коміт за це вікно або посилання з чинного входу (README, паспорт). Коміт, який лише створив звіт, не рахується як читач.

## Завдання 1. Реєстр

Тип «продукт» — документ, який має змінюватися разом із системою. Тип «процес» — запис факту в часі (звіт, шаблон PR, повідомлення коміту, лабораторний workflow).

| Документ | Тип | Категорія | Аудиторія | Не закриває | Власник останнього коміту | Вік, днів | Вердикт |
|---|---|---|---|---|---|---|---|
| `README.md` | продукт | експлуатаційна і для бізнесу | новачок, бізнес | контракти між сервісами | Vlad Antoniuk | 156 | оновити |
| `docs/ai-guides/ARCHITECTURE.md` | продукт | архітектурна | розробники | порядок запуску, RTO | babay | 28 | оновити лише разом із наступною зміною архітектури |
| `docs/ai-guides/PROJECT-OVERVIEW.md` | продукт | архітектурна | розробники, бізнес | актуальний статус клієнта | Babay | 191 | оновити |
| `docs/ai-guides/MICROSERVICES.md` | продукт | технічна | розробники, QA | тіло `/health` розходиться з кодом | Babay | 177 | оновити |
| `docs/ai-guides/DOCKER-SETUP.md` | продукт | експлуатаційна | DevOps | цілі RTO/RPO | Babay | 191 | оновити |
| `docs/ai-guides/PROJECT-STATUS.md` | продукт | технічна | розробники, QA | зміни після 2026-05-29 | Babay | 177 | оновити |
| `docs/ai-guides/AUDIT-LOG-API.md` | продукт | технічна | QA, розробники | — (змісту не спростовано) | Babay | 198 | оновити при наступній зміні API журналу |
| `docs/ai-guides/AUDIT-COVERAGE-MATRIX.md` | продукт | технічна | QA | експлуатація | Babay | 177 | оновити при зміні таблиць |
| `docs/ai-guides/AUDIT-AGENT-REQUIREMENTS.md` | процес | технічна | розробники | бізнес, DevOps | Babay | 198 | deprecated як інструкція агенту, не як опис продукту |
| `docs/ai-guides/FRONTEND-UI.md` | продукт | технічна | розробники | бекенд | NatalieShostak6 | 172 | оновити при зміні UI |
| `docs/runbooks/RABBITMQ-CHOREOGRAPHY.md` | продукт | експлуатаційна | DevOps | бізнес | Babay | 191 | оновити |
| `DOCKER-BUILD.md` | продукт | експлуатаційна | DevOps, новачок | RTO/RPO | Babay | 213 | оновити |
| `DATABASE.md` | продукт | технічна | розробники, QA | порядок контейнерів | babay | 28 | оновити лише зі схемою |
| `SETUP-GUIDE.md` | продукт | експлуатаційна | новачок | контракти | Vlad Antoniuk | 163 | оновити |
| `SCALAR-GUIDE.md` | продукт | технічна | QA, розробники | розгортання | Babay | 198 | оновити |
| `AI-GUIDES-INDEX.md` | продукт | архітектурна | розробники | бізнес | Babay | 177 | оновити |
| `.env.example` | продукт | експлуатаційна | DevOps | семантика контрактів | Vlad Antoniuk | 165 | оновити при новій змінній |
| `Client/.env.example` | продукт | експлуатаційна | DevOps | бекенд | Babay | 228 | оновити |
| `docker-compose.yaml` | продукт | експлуатаційна | DevOps | навіщо такий порядок | babay | 35 | оновити разом із ISD |
| `.github/workflows/ci.yaml` | продукт | експлуатаційна | DevOps, QA | призначення продукту | babay | 35 | оновити разом із ISD |
| `Core/README.md` | продукт | технічна | розробники | усі інші аудиторії, і розробників теж: текст про порожню модель | Babay | 228 | deprecated |
| `Graph/README.md` | продукт | технічна | розробники | те саме: хаб досі «заглушка» | Babay | 228 | deprecated |
| `Gateway/README.md` | продукт | технічна | розробники, DevOps | JWT досі «заглушка» | Babay | 228 | deprecated |
| `ML/README.md` | продукт | технічна | розробники | є лише stub `recalculate` | Babay | 228 | deprecated |
| `Migration/README.md` | продукт | експлуатаційна | DevOps | `entrypoint.sh` і «міграції в Core» | Babay | 228 | deprecated |
| `Client/README.md` | продукт | технічна | розробники | клієнт досі «скелет» | Babay | 228 | deprecated |
| `Authentication/README.md` | продукт | технічна | розробники | 2FA, листи, приватність | Vladyslav Kostenuk | 198 | оновити |
| `Audit/README.md` | продукт | технічна | розробники, QA | розгортання | Babay | 204 | оновити |
| `ENDPOINTS/ENDPOINTS_ENG.md`, `ENDPOINTS_UA.md` | продукт | технічна | QA | розгортання | Babay | 161 | оновити |
| `ENDPOINTS/POSSIBLE_PRO_VERSION_*.md` | продукт | технічна | бізнес | те, що вже працює | Babay | 156 | deprecated |
| `BENEFITS.md`, `BENEFITS_UA.md` | продукт | для бізнесу | бізнес | як запустити | Babay | 156 | deprecated |
| `docs/PROMOTION-STRATEGY.md` | процес | для бізнесу | бізнес | контракти і запуск | NatalieShostak6 | 156 | deprecated |
| `CONTRIBUTORS.md` | процес | — | — | усі чотири аудиторії системи | Vlad Antoniuk | 248 | deprecated |
| `.github/pull_request_template.md` | процес | експлуатаційна | розробники | поведінка продукту | Babay | 228 | оновити, якщо зміниться чеклист PR |
| `lab2/REPORT.md`, `lab3/REPORT.md` | процес | — | викладач | операційна карта | babay | 35 | deprecated як інструкція до системи |
| `lab4/` … `lab9/` звіти | процес | — | викладач | операційна карта | babay | 28 | deprecated як інструкція до системи |
| `.github/workflows/lab5-quality-gate.yaml`, `lab7-hotspots.yaml`, `lab8-design.yaml` | процес | експлуатаційна | QA курсу | виклад релізу | babay | 28 | deprecated як продуктовий конвеєр |
| Повідомлення комітів | процес | — | розробники | новачок і бізнес | автор коміту | — | не видаляти історію |
| Коментарі в коді | продукт | технічна | розробники | QA, DevOps, бізнес | автор рядка | — | оновлювати разом із кодом, не замість паспорта |
| `docs/USER-GUIDE.md` | — | — | новачок | файлу немає, README на нього посилався | — | — | посилання прибрати |

Зовнішнє посилання README на Google Doc не має дати в git. Воно не замінює паспорт.

Команди, якими знято вік і лічильники (повний вивід — у evidence):

```text
git log -1 --format=%cs -- README.md
2026-06-19

git log -1 --format=%cs -- Core/README.md
2026-04-08

git log -1 --format=%cs -- docs/ai-guides/ARCHITECTURE.md
2026-10-25

git rev-list --count HEAD -- Core
100
git rev-list --count HEAD -- Core/README.md
1

bash -lc "git log --oneline -- Core | wc -l"
100
bash -lc "git log --oneline -- Core/README.md | wc -l"
1
bash -lc "git log --oneline -- Graph | wc -l"
43
bash -lc "git log --oneline -- Graph/README.md | wc -l"
1
```

Коміти коду, досяжні після останнього коміту документа (`git rev-list --count <commit-документа>..HEAD -- <код>`), на зрізі `5b07227`:

| Документ | Код | Комітів коду після документа |
|---|---|---:|
| `Core/README.md` | `Core` | 100 на весь шлях, документ комітився один раз |
| `Graph/README.md` | `Graph` | 43 проти 1 |
| `Migration/README.md` | `Migration` | 61 проти 1 |
| `ML/README.md` | `ML` | 24 проти 1 |
| `Gateway/README.md` | `Gateway` | 23 проти 1 |
| `Client/README.md` | `Client` | 113 проти 1 |
| `docs/ai-guides/PROJECT-OVERVIEW.md` | `Core` | 37 |
| `docs/ai-guides/MICROSERVICES.md` | `Graph` | 27 |
| `DOCKER-BUILD.md` | `docker-compose.yaml` | 17 |
| `docs/ai-guides/AUDIT-LOG-API.md` | `Audit` | 12 |
| `Authentication/README.md` | `Authentication` | 12 |
| `DATABASE.md` | `Persistence` | 0 |
| `docs/ai-guides/ARCHITECTURE.md` | `Core` | 0 |
| `docs/ai-guides/ARCHITECTURE.md` | `Graph` | 13 |

Тринадцять комітів Graph після `b71a8fe` (останній дотик ARCHITECTURE) — це фікстури ЛР6–ЛР8: `DesignAudit/` і `DealCommercialOption`. Нового сервісу там немає. `git diff --stat b71a8fe..HEAD -- Graph` дає 9 файлів, 635 вставлених рядків, усі в цих фікстурах і їхніх тестах.

Поріг «понад 20 змін коду без оновлення документа» пройдено для README сервісів Core, Graph, Migration, ML, Gateway, Client і для `PROJECT-OVERVIEW.md` та `MICROSERVICES.md`. Для `DOCKER-BUILD.md` (17) і `AUDIT-LOG-API.md` (12) поріг відношення не пройдено. Вік понад 180 днів усе одно ставить їх у «ймовірно застарілі».

## Діагноз антипатернів

Documentation Decay — документ описує систему, якої вже немає.

- `Core/README.md` пише, що модель EF порожня і міграції живуть у Core. Код Migration викликає `MigrateAsync`, схема в `Relativa.Migration`. 100 комітів `Core` проти одного коміту цього README.
- `Graph/README.md` називає хаб SignalR порожньою заглушкою. У коді є `GET /api/v1/graph` і `GET /api/v1/dashboard/*`. 43 коміти проти одного.
- `Gateway/README.md` називає перевірку JWT заглушкою. Шлюз перевіряє токен і підставляє `X-User-Id`.
- `ML/README.md` знає лише stub `POST /api/ml/recalculate/`. У `ML/ml_api/urls.py` є ще `health` і `score/batch`.
- `Migration/README.md` описує `entrypoint.sh`, який виходить з кодом 0. Цього сценарію в `Program.cs` немає.
- `Client/README.md` описує скелет Vite і граф-заглушку. Клієнт уже веде онбординг і граф.
- `README.md` посилався на `docs/USER-GUIDE.md`. Файлу немає (`Test-Path` = false). Це розпад входу для новачка, навіть при віці 156 днів (ще не 180) і при 10 комітах Core після README (поріг 20 не взято).
- `MICROSERVICES.md` віддає тіло `/health` як `status: Healthy`. Код шлюзу повертає `status: ok`.

Dead Documentation — документ є, споживача за останній місяць немає.

- `BENEFITS.md`, `BENEFITS_UA.md`, `docs/PROMOTION-STRATEGY.md`, `ENDPOINTS/POSSIBLE_PRO_VERSION_*.md`, `CONTRIBUTORS.md`: нуль комітів з 2026-10-23, у швидкий старт і в паспорт вони не входять. Це не інструкція до системи.
- Шість сервісних README з банером deprecated одночасно і мертві, і розкладені: їх не чіпали з квітня, і текст суперечить коду. Мертвий брехливий документ небезпечніший за відсутній, бо виглядає як інструкція.

Видаляти ці файли не став. Єдиний примірник пітчу, списку учасників і старого тексту README зник би разом із контекстом, чому банер стоїть. Небезпечний текст позначено deprecated на місці: банер каже не виконувати абзаци нижче і дає посилання на SDD та ISD. Для маркетингових файлів вердикт deprecated без банера: вони не описують запуск, їх не читають як runbook.

`ARCHITECTURE.md` і `DATABASE.md` під пороги розпаду не потрапили. Тринадцять комітів Graph після архітектурного гайда — лабораторні фікстури, не нова межа системи.

## Завдання 2. Паспорт

Коміт паспорта: `80c9cac` `docs(architecture): deliver design and infrastructure passport`.

Повний текст на момент ЛР10 лежав у `docs/sdd.md` і `docs/isd.md`. Після міграції ЛР11 ті самі файли: [SDD](../docs/architecture/sdd.md), [ISD](../docs/architecture/isd.md), [ADR-0001](../docs/architecture/adr/ADR-0001-shared-postgresql.md), [ADR-0002](../docs/architecture/adr/ADR-0002-asynchronous-messaging.md). Команди нижче лишаються з шляхами комітів ЛР10.

### C4, контейнери

Діаграма з SDD на момент після PASS (вузол operator digest додано відновленням, див. завдання 3):

```mermaid
flowchart LR
  operator["Оператор продажів"]
  client["Client<br/>Vue 3, порт 3000"]
  gateway["Gateway<br/>YARP, порт 8080"]
  auth["Authentication<br/>.NET, порт 8081"]
  core["Core<br/>.NET, порт 8082"]
  graph["Graph<br/>.NET, порт 8083"]
  ml["ML<br/>Django, порт 8084"]
  audit["Audit<br/>.NET, порт 8086"]
  migration["Migration<br/>EF Core, разовий запуск"]
  pg[("PostgreSQL 16")]
  mq["RabbitMQ 3.13"]

  operator --> client --> gateway
  gateway -->|HTTP /auth| auth
  gateway -->|HTTP /core| core
  gateway -->|HTTP /graph| graph
  gateway -->|HTTP /ml| ml
  gateway -->|HTTP /audit| audit
  migration --> pg
  auth --> pg
  core --> pg
  graph --> pg
  ml --> pg
  audit --> pg
  auth -->|outbox| mq
  core -->|outbox| mq
  mq -->|audit.events| audit
  mq -->|relativa.domain| graph
  mq -->|relativa.domain| ml
  graph -->|RPC relativa.graph_ml| ml
  gateway -->|локальний маршрут| digest["Operator digest<br/>GET /api/v1/operator/digest"]
```

Контейнери до краш-тесту ті самі, без вузла digest. Браузер ходить лише в Gateway. Синхронного HTTP між бекендами немає. Graph просить оцінку в ML через AMQP RPC `relativa.graph_ml`. Модель даних у SDD — фрагмент організація / простір / користувач / entity EAV / зв'язок / журнал. Повні колонки лишаються в `DATABASE.md`.

### ISD, RTO і RPO

Середовища: dev — Compose на `relativa_net`; test — той самий Compose у `ci.yaml`; production-маніфесту немає. Відкат коду — попередній git і перезбірка сервісу. Відкату схеми вниз немає.

Цілі і факт з ISD:

| Сховище | Ціль RPO | Ціль RTO | Факт на dev |
|---|---|---|---|
| PostgreSQL, том `postgres_data` | 24 години | 4 години | Дампа немає. `docker compose down -v` знищує рядки |
| `audit_outbox` у тій самій базі | 24 години | 4 години | Недоставлене переживає рестарт брокера |
| RabbitMQ без тома | 0 для непідтверджених повідомлень | у межах тих самих 4 годин | Повтор іде з outbox |
| Образи | не дані | перезбірка Compose | Відкат — git, не реєстр |

CI: тести Authentication, Core, Messaging, Audit, Graph; coverage line і branch ≥ 80% на збірку; gitleaks і аудит NuGet блокують. E2E блокує не-draft PR. Load має `continue-on-error: true` і merge не блокує. Гілка `testing/lab10` за push цей workflow не запускає: тригер — `release/**`, `feature/**` і PR у `main`.

### ADR

Обидва записи створені 2026-11-22 зі статусом Accepted. Рішення вже було в коді. Запис не підміняє дату комітів і надалі не редагується. Зміна вибору — новий номер і статус Superseded на старому.

ADR 0001. Одна PostgreSQL і спільна бібліотека Persistence. Альтернативи: база на сервіс, схема на сервіс, документна база під EAV. Обрано одну базу і `MigrateAsync` лише з Migration, бо граф читає ту саму модель, що пише Core, а outbox комітиться разом зі зміною рядка. Наслідок: простій бази зупиняє всіх, зате немає розподіленої транзакції на аудит.

ADR 0002. Outbox і RabbitMQ. Альтернативи: синхронний HTTP між сервісами, інша шина, запис журналу самим Core. Обрано `audit.events`, `relativa.domain` і RPC `relativa.graph_ml`. Наслідок: угода зберігається, навіть якщо ML у цю секунду мертвий; споживач має бути ідемпотентним; брокер без тома відновлюється з бази.

### Матриця аудиторій

Повна таблиця — [docs/audience-matrix.md](../docs/audience-matrix.md). До паспорта була одна дірка входу: README обіцяв `docs/USER-GUIDE.md`, файлу не було, і не було шляху від клону до карти сервісів. Її закрито розділом Onboarding у README і посиланнями на SDD, ISD, регламент. Питання розробника закриває SDD, QA — контракти SDD і Scalar, DevOps — порядок і RTO/RPO в ISD, бізнесу — розділи What is Relativa і Features. Окремий рядок про operator digest з'явився під час відновлення, не в першому коміті паспорта.

## Завдання 3. Супровід

Регламент — [docs/maintenance.md](../docs/maintenance.md). Власник паспорта — Babay. README і ISD переглядаються кожні 90 днів, SDD і ADR — кожні 180. Правило: зміна коду = зміна документації. Той самий рядок додано в `AI-GUIDES-INDEX.md`.

### Краш-тест, FAIL

Коміт `22a20df` `docs(audit): simulate documentation decay, FAIL`. У ньому лише код і Compose. Жодного рядка README, SDD, ISD, регламенту.

```text
git diff --stat 80c9cac 22a20df
 Gateway/src/Relativa.Gateway/OperatorDigestEndpoints.cs | 17 +++++++++++++++++
 Gateway/src/Relativa.Gateway/Program.cs                 |  3 +++
 docker-compose.yaml                                     |  2 ++
 3 files changed, 22 insertions(+)
```

Поведінка: `GET /api/v1/operator/digest` без токена, тіло `kind` = `operator-digest`, `includes` = `openDeals`, `highRiskDeals`, `pendingInvitations`. Шлюз відповідає сам, не через Core. Розгортання: у `graph.depends_on` додано `ml: condition: service_started`. До цього Graph стартував паралельно з ML.

Дрейф по аудиторіях на `22a20df`. `git grep operator-digest 22a20df -- README.md docs/sdd.md docs/isd.md` не знаходить рядків (код виходу 1).

- Новачок і бізнес. README після паспорта описує health і не описує digest. Призначення «що оператор може спитати без токена» не збігається з процесом шлюзу.
- Розробники і QA. SDD не має компонента `OperatorDigestEndpoints` і не має цього контракту. Це дрейф структури: тип є в `Gateway/src`, у C4 його немає.
- DevOps. ISD на цьому коміті ще каже: «Graph не чекає ML. Обидва кроки 3 йдуть паралельно.» Compose вже ставить Graph у чергу за контейнером ML.

Метрики. Вік SDD у днях не виріс: і паспорт, і FAIL датовані 2026-11-22, вік 0. Розклад видно у відношенні комітів, не в календарі.

```text
git log --oneline 80c9cac -- Gateway/src | wc -l     21
git log --oneline 22a20df -- Gateway/src | wc -l     22
git log --oneline 80c9cac -- docs/sdd.md | wc -l      1
git log --oneline 22a20df -- docs/sdd.md | wc -l      1
git rev-list --count 80c9cac..22a20df -- Gateway/src  1
```

Один коміт сирців Gateway після останнього коміту SDD, нуль комітів самого SDD. Останній коміт `docker-compose.yaml` на FAIL — `22a20df`. Останній коміт `docs/isd.md` на FAIL — `80c9cac`.

Шлях `Gateway/` без `src` рахує ще й `Gateway/README.md`, який чіпав паспорт. Тому лічильник усього каталогу Gateway стрибає 23 (lab9) → 24 (паспорт) → 25 (FAIL). Для відношення код/документ береться `Gateway/src`.

### Відновлення, PASS

Коміт `e8f1346` `docs(maintenance): restore documentation currency, PASS`.

- README, крок 3 онбордингу: адреса digest, склад `includes`, що це не проксі і не лічильник угод.
- SDD: вузол на C4, рядок компонента, розділ Operator digest, рядок контракту, речення що Graph чекає старт ML.
- ISD: крок 4 — `graph` чекає `ml` з `service_started`. Речення «Graph не чекає ML» знято.
- Регламент: повторний перегляд 2026-11-22, розбіжностей немає.
- Матриця: рядок новачка про зріз без токена, статус покрито.

```text
git log --oneline HEAD -- docs/sdd.md | wc -l                 2
git rev-list --count <останній коміт sdd>..HEAD -- Gateway/src  0
```

Відношення повернулося: після останнього коміту SDD комітів `Gateway/src` немає. Вік знову 0 днів, бо PASS того самого дня. Календарний вік цей дослід не міг зіпсувати. Зіпсувати і полагодити він міг лише розрив комітів, і це видно в логу.

### Handover і Bus Factor

Пакет — [docs/handover.md](../docs/handover.md). П'ять кроків онбордингу збігаються з README. Жоден каталог не належить одному автору комітів після злиття написань одного й того самого автора. Темні зони до паспорта були там, де README брехав, а комітів одного автора було багато: Gateway (Babay 19 з 23 до експерименту), Migration (Babay 43 з 61), ML (Babay 15 і Vlad Antoniuk 7 з 24). План зняття — паспорт як другий примірник знання і другий читач на наступну зміну маршруту, схеми або моделі.

## Діагноз

Шість README сервісів описують систему квітня 2026: порожню модель у Core, порожній хаб у Graph, JWT-заглушку в Gateway, stub `recalculate` в ML і `entrypoint.sh` з кодом 0 в Migration. На зрізі 2026-11-22 код уже віддає граф, дашборд, перевірку JWT, `MigrateAsync` і `score/batch`. На кожен із цих файлів припадає один коміт документа і понад 20 комітів коду, вік більший за 180 днів, а з 2026-10-23 їх ніхто не змінював. Це Documentation Decay. `BENEFITS.md` і `docs/PROMOTION-STRATEGY.md` за той самий місяць не мають коміту і не входять у шлях онбордингу. Порядок контейнерів вони не задають, споживача в репозиторії немає. Це Dead Documentation. Сервісні README я позначив банером deprecated, бо за старим текстом можна підняти не той сервіс.

## Наслідки ADR

Спільна PostgreSQL з ADR 0001 зводить простій до однієї точки: падає база — зупиняються Auth, Core, Graph, Audit і ML. Резервна копія теж одна, ціль RPO 24 години стоїть на томі `postgres_data`. Журнал при цьому пишеться в тій самій транзакції, що й угода, без розподіленого коміту. ADR 0002 лишає чергу, бо збереження угоди має пережити повільний ML. Споживач зобов'язаний бути ідемпотентним. У Compose у RabbitMQ немає тома: непідтверджене повідомлення після перестворення контейнера зникає, повторна публікація йде з `audit_outbox`.

## Вердикт передачі

Після коміту PASS `e8f1346` операційну карту можна передати. П'ять кроків README доводять до `GET /health`, до `GET /api/v1/operator/digest`, далі до SDD і ISD. Для запуску і меж сервісів стан Ready to Handover. Колонки EAV передаються через `DATABASE.md`: останній коміт цього файлу 2026-10-25, після нього комітів у `Persistence` немає. Gateway (Babay 19 з 23 до експерименту), Migration (Babay 43 з 61) і ML (Babay 15 і Vlad Antoniuk 7 з 24) лишаються авторськи важкими. Наступна зміна маршруту, схеми або моделі йде з другим читачем і з рядком у SDD або ISD в тому самому коміті.

## Лог валідації

Краш-тест пройдено двома комітами на `testing/lab10`:

| Стан | Коміт | Що в дереві |
|---|---|---|
| Паспорт | `80c9cac` | SDD, ISD, два ADR, регламент, матриця, онбординг README. Digest у коді немає |
| FAIL | `22a20df` | Digest і `graph.depends_on.ml`. Документи паспорта не змінені |
| PASS | `e8f1346` | Ті самі документи знову збігаються з кодом. `Gateway/src` після останнього SDD: 0 комітів |

Перевірка, яку можна повторити:

```text
git branch --show-current
git log -4 --oneline
git grep -n "operator-digest" 22a20df -- README.md docs/sdd.md docs/isd.md
git grep -n "не чекає ML" 22a20df -- docs/isd.md
git grep -n "operator-digest" HEAD -- README.md docs/sdd.md
git rev-list --count 22a20df -- Gateway/src
git rev-list --count 22a20df -- docs/sdd.md
```

Перший grep на FAIL має завершитися без рядків. Другий має показати речення ISD про паралельний старт. На HEAD обидва документи digest уже містять.
