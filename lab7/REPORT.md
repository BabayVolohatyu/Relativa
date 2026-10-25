# Лабораторна робота №7

Інформаційна складність за Чепіним та критичні зони (Hotspots)

Проєкт: Relativa. Об'єкт аудиту — `DealCommercialOption.Evaluate` у [DealCommercialOption.cs](../Graph/src/Relativa.Graph/Dashboard/DealCommercialOption.cs). Це лінійне котирування комерційної опції угоди на дашборді Graph, наступник довідника з ЛР6. Сирі журнали лежать у [lab7/evidence](evidence). Сканер і зведення квадратів — [scan-hotspots.py](scan-hotspots.py).

`GetSummaryAsync` у `WorkspaceDashboardService` і `DashboardService` не змінювався. Хук ЛР6 відхиляє staged-файл, якщо будь-який його метод має CCN > 10, а в цих двох файлах такі методи вже є.

## Декларація об'єкта

Метод — `DealCommercialOption.Evaluate(status, stage, riskBand, accessLevel, closingThisMonth, clientActive)`. Він збирає ту саму суму поправок, що й довідник ЛР6: п'ять тестів лишились із тими самими очікуваними числами (0.06, 0.00, 0.13, 0.43, 0.00). `ScoreLegacyTier` не входить в аудит.

Наприкінці ЛР6 тіло було одним `Math.Round` без локальних змінних, CCN 1. Для Чепіна цього мало: немає модифікованих проміжних сум, які можна зіпсувати записом. Базовий стан цієї роботи, коміт `c9253b6` (`audit: record mutable linear quote flow`), розгортає той самий підрахунок у послідовність локальних сум. Словники статусу, стадії, ризику, доступу і пари «closed або Negotiation» лишились. Пара `(closingThisMonth, clientActive) → 0.07` стала предикатом, бо інакше в методі не було б жодної керуючої змінної. Словник `ClosingDelta` після цього не читається і з файлу прибраний.

Lizard 1.24.3, ті самі прапорці, що в ЛР6:

```text
python -m lizard -C 5 -L 99999 -a 99999 -l csharp Graph/src/Relativa.Graph/Dashboard/DealCommercialOption.cs
```

`-C 5` завершується з кодом 0, коли CCN не більший за 5. Журнал базового стану — [lizard-baseline.txt](evidence/lizard-baseline.txt). Рядок методу:

```text
29  3  162  6  33  DealCommercialOption::Evaluate@49-81
```

CCN = 3. База 1, `if` дає +1, `&&` дає +1. Це той самий розклад, який ЛР6 вже звірила на моноліті. Межа лабораторної CC ≤ 5 витримана. Хук на коміті дивиться поріг 10 і теж пропустив файл.

## Семантична матриця Чепіна

Формула: `Q = P + 2M + 3C + 0.5T`.

Одна змінна має один клас. Якщо ролей кілька, береться вища за порядком C, потім M, потім P, потім T. У таблицю входять усі імена, які `Evaluate` читає або пише в коміті `c9253b6`, включно зі статичними словниками. `Math`, числові літерали і параметр `token` методу `RecordTrace` сюди не входять: це інший метод.

Правило для локальних сум: ім'я, якому алгоритм присвоює обчислене значення, є M, бо стан змінної створюється перетворенням входу. `closingDelta`, `running` і `payable` до того ж перезаписуються. Саме `running` є поверхнею мутації в коміті FAIL.

| Змінна | Тип | Клас | Вага | Обґрунтування |
|---|---|---|---:|---|
| `status` | `string` | P | 1 | Аргумент, читається як ключ словника, у тілі не змінюється і не стоїть в умові |
| `stage` | `string` | P | 1 | Те саме для стадії і для ключа пари closed/Negotiation |
| `riskBand` | `string` | P | 1 | Ключ словника ризику, лише читання |
| `accessLevel` | `string` | P | 1 | Ключ словника доступу, лише читання |
| `StatusDelta` | `Dictionary<string, decimal>` | P | 1 | Статична таблиця, у методі тільки `GetValueOrDefault` |
| `StageDelta` | `Dictionary<string, decimal>` | P | 1 | Те саме для стадії |
| `RiskDelta` | `Dictionary<string, decimal>` | P | 1 | Те саме для ризику |
| `AccessDelta` | `Dictionary<string, decimal>` | P | 1 | Те саме для доступу |
| `ClosedOrNegotiation` | `Dictionary<(string, string), decimal>` | P | 1 | Те саме для пари статус/стадія |
| `statusDelta` | `decimal` | M | 2 | Локальна сума, записана з таблиці |
| `stageDelta` | `decimal` | M | 2 | Локальна сума, записана з таблиці |
| `riskDelta` | `decimal` | M | 2 | Локальна сума, записана з таблиці |
| `accessDelta` | `decimal` | M | 2 | Локальна сума, записана з таблиці |
| `stackDelta` | `decimal` | M | 2 | Локальна сума пари closed/Negotiation |
| `closingDelta` | `decimal` | M | 2 | Спочатку 0, потім 0.07, якщо спрацював предикат. В умові не стоїть |
| `running` | `decimal` | M | 2 | Накопичувач, перезаписується кожним доданком |
| `payable` | `decimal` | M | 2 | Копія `running`, потім результат `Math.Round` |
| `closingThisMonth` | `bool` | C | 3 | Вхід, але стоїть у `if`. Ієрархія лишає C, не P |
| `clientActive` | `bool` | C | 3 | Другий операнд того самого `&&`. Теж C, не P |
| `traceToken` | `string` | T | 0.5 | Створюється лише щоб піти аргументом у `RecordTrace` |

Підрахунок:

- P = 9, внесок `9 · 1 = 9`
- M = 8, внесок `8 · 2 = 16`
- C = 2, внесок `2 · 3 = 6`
- T = 1, внесок `1 · 0.5 = 0.5`

`Q = 9 + 16 + 6 + 0.5 = 31.5`.

Шкала, якою читається це число: до 20 низька інформаційна складність, від 20 до 60 середня, понад 60 висока. 31.5 лежить у середній смузі. Цикломатична складність того самого тіла дорівнює 3, тож Мак-Кейб бачить лінійний метод. Різниця якраз у восьми M: будь-яке з них можна перезаписати новим присвоєнням, не додавши жодної гілки і не зрушивши CCN. Вага M дорівнює 2, вага C дорівнює 3, тож одна керуюча змінна «дорожча» за одну модифіковану, але мутація б'є по M, бо саме їх алгоритм переписує.

Ієрархія на цьому тілі спрацювала на двох іменах. `closingThisMonth` і `clientActive` приходять як вхід (це була б роль P, вага 1) і одночасно керують гілкою. Вища роль — C, вага 3. Якби їх порахувати як P, Q впав би на `2 · (3 − 1) = 4` і став би 27.5. У таблиці вони C. Інших збігів ролей немає: `running` лише M, словники лише P, `traceToken` лише T.

## FAIL: перезапис накопичувача

Коміт `06e7768`, повідомлення `audit: simulate data mutation issue, FAIL`. Після того, як `running` уже зібрав усі шість доданків, у метод додано:

```csharp
decimal discount = statusDelta;
running = discount;
```

`discount` забирає лише складову статусу і записує її поверх повної суми. Для угоди closed / Prospecting / high / basic / false / false правильна сума 0.06 (0.15 + 0.02 − 0.10 − 0.05 + 0 + 0.04). Після запису метод повертає 0.15, тобто голу поправку статусу. Це той самий касовий розрив: проміжна знижка замінила базу, а CCN лишився 3, бо нових умов немає.

Очікування тестів не змінювались. Прогін:

```text
dotnet test Graph/tests/Relativa.Graph.Integration.Tests/Relativa.Graph.Integration.Tests.csproj --filter FullyQualifiedName~DealCommercialOption
```

Журнал — [fail-test.txt](evidence/fail-test.txt). Чотири тести `Evaluate` червоні, обидва тести `ScoreLegacyTier` зелені. Підсумок прогону: Failed 4, Passed 3, Total 7.

| Виклик | Очікувалось | Отримано |
|---|---:|---:|
| closed, Prospecting, high, basic, false, false | 0.06 | 0.15 |
| revoked, Negotiation, medium, full, true, true | 0.00 | −0.20 |
| open, Proposal, low, full_org, true, false | 0.13 | 0.00 |
| closed, Negotiation, low, full_org, true, true | 0.43 | 0.15 |

Третій зелений тест — `pending` на стадії Prospecting. Його очікування 0.00, а `statusDelta` для невідомого статусу теж 0, тож перезапис `running = discount` дає ту саму нульову суму. Мутація в цьому рядку непомітна. Саме тому один зелений тест на `Evaluate` не спростовує збій: чотири інші рядки розходяться з контрактом ЛР6.

## PASS: незмінний об'єкт-значення

Коміт `70932a0`, повідомлення `refactor(audit): reduce Chapin complexity using immutable Value Objects, PASS`.

Словники, предикат закриття місяця і `Math.Round` переїхали в `readonly record struct DealAdjustment`. Сума фіксується в конструкторі як `Rounded`. Сеттера немає: повторний розрахунок створює інший екземпляр, а не пише в старий. `Evaluate` більше не тримає локальних сум.

Було (`c9253b6`):

```csharp
decimal closingDelta = 0m;
if (closingThisMonth && clientActive)
    closingDelta = 0.07m;

decimal running = 0m;
running = running + statusDelta;
running = running + stageDelta;
running = running + riskDelta;
running = running + accessDelta;
running = running + closingDelta;
running = running + stackDelta;

decimal payable = running;
payable = Math.Round(payable, 2);
return payable;
```

Стало (`70932a0`):

```csharp
public static decimal Evaluate(
    string status,
    string stage,
    string riskBand,
    string accessLevel,
    bool closingThisMonth,
    bool clientActive)
{
    string traceToken = "deal-option";
    RecordTrace(traceToken);
    return DealAdjustment.From(
        status,
        stage,
        riskBand,
        accessLevel,
        closingThisMonth,
        clientActive).Rounded;
}
```

`const` для цих сум не підходить: вони обчислюються під час виклику. Незмінність тут інша. Шість аргументів і `traceToken` у тілі `Evaluate` ніде не перезаписуються. Кожен із них існує лише щоб дійти до `DealAdjustment.From` або до `RecordTrace`. За визначенням транзитної змінної всі сім — T.

| Змінна | Тип | Клас | Вага | Обґрунтування |
|---|---|---|---:|---|
| `status` | `string` | T | 0.5 | Лише аргумент `From` |
| `stage` | `string` | T | 0.5 | Лише аргумент `From` |
| `riskBand` | `string` | T | 0.5 | Лише аргумент `From` |
| `accessLevel` | `string` | T | 0.5 | Лише аргумент `From` |
| `closingThisMonth` | `bool` | T | 0.5 | У `Evaluate` вже не стоїть в `if`, лише передається |
| `clientActive` | `bool` | T | 0.5 | Те саме |
| `traceToken` | `string` | T | 0.5 | Як і раніше, лише для `RecordTrace` |

P = 0, M = 0, C = 0, T = 7.

`Q = 0 + 0 + 0 + 0.5 · 7 = 3.5`.

Відношення до бази: `31.5 / 3.5 = 9`. Поріг лабораторної — падіння щонайменше вдвічі (`31.5 / 2 = 15.75`). 3.5 менше за 15.75. Клас M у самому `Evaluate` зник, тож перезапис на кшталт `running = discount` у цьому методі більше немає куди покласти.

Предикат і словники нікуди не зникли з програми: вони всередині `DealAdjustment.From`. Повторний аудит рахує змінні `Evaluate`, як просить завдання, і окремо фіксує, що керування переїхало в об'єкт-значення. Lizard на PASS, журнал [lizard-pass.txt](evidence/lizard-pass.txt):

```text
21  3  96  6  22  struct::From@8-29
18  1  52  6  18  DealCommercialOption::Evaluate@75-92
```

`Evaluate` має CCN 1. `From` має CCN 3 і лишається під межею 5. Ім'я `struct::From` — це позначка Lizard для методу record-структури `DealAdjustment.From`.

Ті самі сім тестів після PASS зелені: Failed 0, Passed 7. Журнал — [pass-test.txt](evidence/pass-test.txt).

## Git

```text
70932a0 refactor(audit): reduce Chapin complexity using immutable Value Objects, PASS
06e7768 audit: simulate data mutation issue, FAIL
c9253b6 audit: record mutable linear quote flow
```

Повний фрагмент — [git-graph.txt](evidence/git-graph.txt). Порядок станів: базова лінійна сума, потім зіпсований перезапис, потім об'єкт-значення. Повідомлення FAIL не починається з `feat:`.

## CI/CD

Пайплайн — [.github/workflows/lab7-hotspots.yaml](../.github/workflows/lab7-hotspots.yaml). Він не вшитий у загальний `ci.yaml`: той працює на `release/**` і `feature/**` і на `lab7` не стартує. Окремий workflow ставиться на `push` гілки `lab7` і на `workflow_dispatch`.

```yaml
name: Lab 7 hotspot scan

on:
  push:
    branches: [lab7]
  workflow_dispatch:

jobs:
  scan:
    name: Lizard complexity artifact
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'

      - name: Install Lizard
        run: pip install lizard==1.24.3

      - name: Scan repository
        run: python lab7/scan-hotspots.py --out lab7/out

      - uses: actions/upload-artifact@v4
        with:
          name: chapin-hotspot-report
          path: lab7/out/
          retention-days: 14
```

На кожному запуску раннер ставить Lizard 1.24.3, сканує репозиторій скриптом і віддає каталог `lab7/out/` артефактом `chapin-hotspot-report`. `fetch-depth: 0` потрібен, щоб `git log` у скрипті бачив історію, а не один коміт. Тести .NET цей job не ганяє: артефакт — це JSON складності і квадратів.

Скріншот зеленого job у хмарі в цей звіт не входить. Гілка `lab7` ще не запушена, тож Actions цей файл ще не виконував. Після `git push` знімок Job Success і артефакта треба покласти поруч із [evidence](evidence). Локальний прогін того самого скрипта вже є: `files=402`, JSON нижче зібраний з нього.

## Churn

Команда з методички, без вікна дат. Повний вивід — [churn-all.txt](evidence/churn-all.txt), 1573 шляхи.

```text
git log --format=format: --name-only | egrep -v '^$' | sort | uniq -c | sort -nr
```

Верх списку:

```text
37 docs/ai-guides/PROJECT-STATUS.md
35 Client/src/layouts/MainLayout.vue
32 Migration/src/Relativa.Migration/Migrations/MigrationDbContextModelSnapshot.cs
29 Core/src/Relativa.Core.Application/Services/EntityService.cs
27 docs/ai-guides/ARCHITECTURE.md
27 Client/src/views/EntityReadView.vue
27 Client/src/router/index.ts
24 docs/ai-guides/MICROSERVICES.md
24 Client/src/views/EntityCreateForm.vue
23 Client/src/views/GraphView.vue
21 docker-compose.yaml
20 Core/src/Relativa.Core/Program.cs
```

Вікно 90 днів. Повний вивід — [churn-90d.txt](evidence/churn-90d.txt), 562 шляхи.

```text
git log --since="90 days ago" --format=format: --name-only | egrep -v '^$' | sort | uniq -c | sort -nr
```

```text
7 Graph/src/Relativa.Graph/Dashboard/DealCommercialOption.cs
4 Core/.sonarqube/out/0/output-cs/token-type.pb
4 Core/.sonarqube/out/0/output-cs/symrefs.pb
4 Core/.sonarqube/out/0/output-cs/metrics.pb
3 Graph/tests/Relativa.Graph.Integration.Tests/DealCommercialOptionTests.cs
```

У `git rev-list --count --since="90 days ago" HEAD` зараз 19 комітів. Усі вони з 17–25 жовтня 2026: лабораторні ЛР2–ЛР7. Останній продуктовий merge, `fd8404c`, датований 2026-06-23. Це поза 90 днями. Уся історія від HEAD — 408 комітів. Тому 90-денний churn майже весь складається з `.sonarqube/**` і з `DealCommercialOption.cs`. Варіант із порожніми комітами і клон чужого репозиторію не використовувались: історія Relativa вже довша за 50 комітів, а `src/**/*.cs` після відсіювання дає 402 файли.

Зведення бере лише `**/src/**/*.cs`. Відкинуто `bin/`, `obj/`, `Migrations/`, `*.Designer.cs` і `.sonarqube/`. Інакше верх таблиці зайняли б `PROJECT-STATUS.md` (37 дотиків, цикломатичної складності немає), Vue-файли клієнта і згенерований знімок міграції (32). Їхні числа лишаються в сирому логу і в матрицю не потрапляють.

## Матриця за 90 днів

Поріг складності: максимальний CCN файлу > 10. Той самий знак, що в хуку і в формулюванні червоної зони.

Поріг churn у цьому вікні: високий від 3 комітів, низький — 0 або 1. Найактивніший вихідний файл вікна має 7 комітів. Поріг 10 позначив би кожен `src`-файл як тихий і стер би єдину активну зону. Два коміти лежать між порогами і квадранта не отримують. Такий файл один: `Authentication/src/Relativa.Authentication/Program.cs`, CCN 1, 2 коміти за 90 днів.

Скрипт на 402 файлах нарахував: High Risk 0, Sleeping Danger 20, Active Development 1, Stable 380, без квадранта 1. Повний список — [hotspots-90d.json](evidence/hotspots-90d.json).

| Файл | max CCN | Коміти за 90 днів | Категорія |
|---|---:|---:|---|
| `Graph/src/Relativa.Graph/Graph/GraphDataService.cs` | 55 (`BuildGraphAsync`) | 1 | Sleeping Danger |
| `Core/src/Relativa.Core.Infrastructure/Repositories/EntityRepository.cs` | 40 (`GetByWorkspaceAsync`) | 0 | Sleeping Danger |
| `Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs` | 37 (`GetTopEntitiesAsync`) | 1 | Sleeping Danger |
| `Core/src/Relativa.Core.Application/Services/EntityService.cs` | 29 (`ReassignRelationshipAsync`) | 0 | Sleeping Danger |
| `Graph/src/Relativa.Graph/Dashboard/DealCommercialOption.cs` | 3 (`DealAdjustment.From`) | 7 | Active Development |
| `Core/src/Relativa.Core.Application/Validators/CreateEntityRequestValidator.cs` | 2 | 0 | Stable |

Червона зона в цих 90 днях порожня. Жоден файл із CCN > 10 не набрав трьох комітів. Наступний спринт не починається з розрізання `EntityService` чи `GraphDataService`: їх зараз ніхто не редагує, і рефакторинг без change request лише створить конфлікти. Їхнє місце — черга на той момент, коли тікет їх справді чіпає. До того це спляча загроза: `BuildGraphAsync` має CCN 55 при одному коміті за вікно, `GetByWorkspaceAsync` — CCN 40 при нулі.

Єдина активна зона — `DealCommercialOption.cs`. Максимум файлу CCN 3, бо Lizard міряє `From`. Сам `Evaluate` після PASS має CCN 1. Файл переписувався сім разів і лишився нижче межі 10. Це зелена зона: робота йде, гілок не додається.

`CreateEntityRequestValidator` — сіра зона: CCN 2, за 90 днів не змінювався. Чіпати його в наступному спринті немає причини.

## Ретроспектива повної історії

90 днів не бачать продуктових комітів до 23 червня 2026. Друга таблиця — той самий Lizard, churn без `--since`. Високий churn тут — 15 комітів і більше. Нижче 15 вважається низьким, інакше квадрант не зібрати. Високий CCN знову > 10. Підсумок скрипта: High Risk 3, Sleeping Danger 17, Active Development 4, Stable 378. Файл — [hotspots-all.json](evidence/hotspots-all.json).

| Файл | max CCN | Коміти за всю історію | Категорія |
|---|---:|---:|---|
| `Core/src/Relativa.Core.Application/Services/EntityService.cs` | 29 | 29 | High Risk |
| `Core/src/Relativa.Core.Infrastructure/Repositories/EntityRepository.cs` | 40 | 17 | High Risk |
| `Core/src/Relativa.Core.Application/Services/OrganizationService.cs` | 11 | 17 | High Risk |
| `Graph/src/Relativa.Graph/Graph/GraphDataService.cs` | 55 | 8 | Sleeping Danger |
| `Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs` | 37 | 9 | Sleeping Danger |
| `Core/src/Relativa.Core/Program.cs` | 1 | 20 | Active Development |
| `Core/src/Relativa.Core.Application/Services/WorkspaceService.cs` | 10 | 15 | Active Development |
| `Core/src/Relativa.Core.Application/Validators/CreateEntityRequestValidator.cs` | 2 | 2 | Stable |

`EntityService` у 90-денній таблиці спить (0 комітів), а за всю історію це головний hotspot: 29 комітів і CCN 29. Поруч `EntityRepository` (17 комітів, CCN 40) і `OrganizationService` (17 комітів, CCN 11). Якщо change request прийде в ці три файли, вони йдуть у рев'ю першими. `GraphDataService` і `WorkspaceDashboardService` навіть за всю історію не дотягують до 15 комітів, хоча CCN у них 55 і 37. Це досі спляча загроза, не червона зона.

`WorkspaceService.CreateAsync` має CCN 10 при 15 комітах. Поріг суворий: вище 10, не «10 і вище». Хук теж пропускає CCN 10. Тому файл лишається в активній зоні, на межі. `DealCommercialOption.cs` за всю історію має 7 комітів, це менше за 15, тож у цій другій таблиці він Stable, хоча за 90 днів він Active. Обидві позначки рахуються зі своїх порогів і не підміняють одна одну.

## Лог краш-тесту

1. Коміт `06e7768` залишає в `Evaluate` рядок `running = discount`. Прогін тестів завершується кодом 1. Closed/Prospecting: очікувалось 0.06, отримано 0.15. Журнал [fail-test.txt](evidence/fail-test.txt).
2. Коміт `70932a0` прибирає накопичувач. Той самий фільтр тестів: Passed 7, код 0. Журнал [pass-test.txt](evidence/pass-test.txt). Lizard: `Evaluate` CCN 1, `From` CCN 3.
3. Ручна перевірка формули бази: `9·1 + 8·2 + 2·3 + 1·0.5 = 9 + 16 + 6 + 0.5 = 31.5`. Після рефакторингу: `0.5 · 7 = 3.5`. `31.5 / 3.5 = 9`, це більше за потрібні 2.
4. Ваги, які захищаються усно: C = 3, M = 2, P = 1, T = 0.5. Вища роль виграє в порядку C, M, P, T. Приклад: `closingThisMonth` виглядає як вхід, але в базі стоїть в `if`, тому клас C, не P. Незмінність означає новий екземпляр `DealAdjustment`, а не запис у стару суму `running`.
