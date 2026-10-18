# Лабораторна робота №3

Maintainability Refactoring та Software Supply Chain Security

Проєкт: Relativa. Об’єкт рефакторингу — `WorkspaceDashboardService.GetSummaryAsync` у сервісі Graph. Сирі журнали лежать у [lab3/evidence](evidence).

## Характеристика проєкту та інструментів

Relativa — CRM із мікросервісами на .NET 10. У цій роботі вимірюється сервіс Graph: він будує граф зв’язків і зведення робочого простору. Код методу — [Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs](../Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs). Залежності рішення [Graph/Relativa.Graph.sln](../Graph/Relativa.Graph.sln) описані в `PackageReference` файлів `Graph/**/*.csproj` (окремого lock-файлу немає).

Тести поведінки методу:

```text
dotnet test Graph/tests/Relativa.Graph.Integration.Tests/Relativa.Graph.Integration.Tests.csproj --filter "FullyQualifiedName~WorkspaceDashboard"
```

| Інструмент | Версія | Команда |
|---|---|---|
| SonarAnalyzer.CSharp | 10.35.0.4138 | `powershell -File lab3/measure-complexity.ps1 -Phase before` |
| NuGet vulnerability audit | SDK 10.0.402 | `powershell -File lab3/sca.ps1 -Phase before` |
| gitleaks | 8.30.1 | `gitleaks detect --source . --config .gitleaks.toml --redact --no-banner` |

Аналізатор складності підключається лише за `-p:Lab3Complexity=true`, тож звичайна збірка і CI його не тягнуть. Правила ті самі до і після: S3776 (Cognitive Complexity) і S1541 (Cyclomatic Complexity), поріг примусово 1, щоб попередження друкувало число і після падіння нижче 15. Поріг задає [lab3/SonarLint.xml](SonarLint.xml). Технічний борг SonarQube в це порівняння не входить: числове «до/після» зняте аналізатором, без нового завантаження на сервер.

## Вимірюваний рефакторинг

Обрано `GetSummaryAsync`. До змін метод займав рядки 115–232 (118 рядків). І базова, і повна гілка доступу окремо розкладали статус угоди на won / lost / open, а повна гілка далі в тих самих циклах рахувала суму, угоди цього місяця, активних клієнтів і прострочені завдання. Вкладеність і дубль однієї класифікації дають Cognitive Complexity 29 і Cyclomatic Complexity 37. Обидва пороги лабораторної (15 і 10) перевищені. Базовий знімок — коміт `2e1b57b`, журнал [complexity-before.txt](evidence/complexity-before.txt).

Поведінка вже була закрита тестами основного й граничних шляхів: повна аналітика, базовий рівень із порожніми фінансами, невідомий статус як open, revoked і прострочені завдання, заборона доступу й архівований простір. Нові тести перед рефакторингом не додавались.

Дві техніки:

1. Extract Method. Підрахунок суми угод, угод із закриттям у поточному місяці, активних клієнтів і прострочених завдань винесено в окремі методи. Жоден із них не вищий за новий метод: найбільший допоміжний метод має Cognitive Complexity 6 і Cyclomatic Complexity 8.
2. Усунення дублювання. Класифікація `closed` / `revoked` / інше зібрана в один `CountDealStatuses`, і його викликають обидві гілки доступу.

Поля DTO, порожні фінанси на базовому рівні, вікно `expected_close` і правило прострочення завдання не змінювались.

Після змін, коміт `0b9e6f6`, той самий аналізатор і той самий поріг:

| Показник | До | Після |
|---|---:|---:|
| Cognitive Complexity | 29 | 7 |
| Cyclomatic Complexity | 37 | 9 |
| Рядків методу | 118 | 64 |

Cognitive Complexity 7 ≤ 15. Цикломатична складність теж нижча: з методу пішли вкладені гілки, лишились перевірка дозволу, вибір базового чи повного рівня і два тернарні підсумки. Журнал — [complexity-after.txt](evidence/complexity-after.txt). Різницю коду показує `git show 0b9e6f6 -- Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs`.

Регресія: 41 тест `WorkspaceDashboard` пройшов, 0 упали ([regression-tests.txt](evidence/regression-tests.txt)).

Цикломатична складність рахує незалежні шляхи виконання. Когнітивна додатково штрафує вкладеність, тому винесення циклів зменшує її сильніше, ніж просте перейменування.

## SCA Security Audit

Інструмент — аудит вразливостей NuGet, аналог `npm audit` для цього стеку. Команда і файли вказані в таблиці вище. NuGet називає середній рівень Moderate; у підсумку він записаний як Medium.

Первинний звіт [sca-before.txt](evidence/sca-before.txt), JSON [sca-before.json](evidence/sca-before.json):

| Рівень | Кількість |
|---|---:|
| Critical | 0 |
| High | 1 |
| Medium | 0 |
| Low | 0 |

Усього компонентів у рішенні Graph: 9 (3 прямі, 6 транзитивні).

Розібрана вразливість:

- Компонент: `Microsoft.OpenApi` 2.0.0, виправлена версія 2.7.5.
- Шлях: транзитивний. Прямий пакет `Microsoft.AspNetCore.OpenApi` 10.0.4 залежить від `Microsoft.OpenApi` 2.0.0.
- Ідентифікатор: GHSA-v5pm-xwqc-g5wc, CVE-2026-49451, рівень High.
- Суть: циклічні посилання в схемі можуть обірвати розбір OpenAPI. Уразливий діапазон гілки 2.x — від `2.0.0-preview.11` до `2.7.4` включно. Перша виправлена версія цієї гілки — 2.7.5.
- Досяжність: пакет стоїть у бойовому Graph (`AddOpenApi` у `Program.cs`), а не лише в тестах. Сервіс генерує власний документ OpenAPI і не розбирає довільний документ від користувача, тож практичний сценарій вужчий за опис advisory. Виправлена версія є, тому ризик не приймався, а залежність оновлена.

Найменший прямий крок, який прибирає advisory: `Microsoft.AspNetCore.OpenApi` 10.0.4 → 10.0.11. Версії 10.0.5–10.0.10 усе ще тягнуть `Microsoft.OpenApi` 2.0.0. 10.0.11 вимагає діапазон `[2.7.5, 3.0.0)` і в цьому рішенні резолвиться в 2.7.5.

Повторний звіт [sca-after.txt](evidence/sca-after.txt): Critical 0, High 0, Medium 0, Low 0, компонентів як і раніше 9. Збірка `dotnet build Graph/Relativa.Graph.sln --configuration Release` успішна. Після оновлення пройшли 45 тестів: `WorkspaceDashboard` і `ResilientMlScoringClientTests` ([sca-tests.txt](evidence/sca-tests.txt)).

Та сама команда в CI — job `supply-chain` у [.github/workflows/ci.yaml](../.github/workflows/ci.yaml). Скрипт із `-FailOnUnresolvedHigh` завершується помилкою, якщо лишається High або Critical без запису в `lab3/sca-accepted.md`. Такого запису немає, бо advisory знято оновленням.

Проєкт інтеграційних тестів не входить у `Relativa.Graph.sln`. Його restore окремо попереджає про `SSH.NET` 2024.2.0 (GHSA-mggc-4xg6-vcxf і GHSA-q939-rpr3-3284) — транзитивна залежність Testcontainers, лише тести. У звіт рішення Graph ці записи не потрапляють.

## Secrets Leak Prevention

Сканер — gitleaks 8.30.1. Конфіг [.gitleaks.toml](../.gitleaks.toml) розширює стандартні правила і не підміняє їх окремим шаблоном лабораторії. Pre-commit [.githooks/pre-commit](../.githooks/pre-commit) запускає `gitleaks protect --staged` і повертає його код. Локально хук вмикається так:

```text
powershell -File lab3/install-hooks.ps1
```

Це пише лише `core.hooksPath=.githooks` у `.git/config` цього клону. Той самий `gitleaks detect` стоїть у job `supply-chain`.

Контрольований провал: [demo-secrets.ps1](demo-secrets.ps1) створює gitignored `lab3/secrets-trap/local.settings.json` з опублікованим навчальним ключем AWS, додає файл у індекс і викликає `git commit`. Вбудоване правило AWS цей навчальний ключ навмисно пропускає, тому в конфіг додано правило `aws-access-key-id` з тією самою формою `AKIA` і 16 символів. Хук завершився з кодом 1, назвав файл, рядок 2 і правило `aws-access-key-id`, секрет у журналі замінено на REDACTED. Коміт не створився. Журнал — [secrets-fail.txt](evidence/secrets-fail.txt).

Після зняття файлу з індексу і видалення з диска `gitleaks detect` по історії гілки завершився з кодом 0: `no leaks found` ([secrets-pass.txt](evidence/secrets-pass.txt)). Файла пастки в історії комітів немає.

Безпечна конфігурація:

- [.gitignore](../.gitignore) ігнорує `.env` і каталог `lab3/secrets-trap/`.
- [.env.example](../.env.example) лишає ключі без бойових секретів, зокрема `DB_PASS` для локального PostgreSQL.
- Graph читає рядок з’єднання через конфігурацію, яку змінна середовища перекриває:

```csharp
var graphConnectionString = builder.Configuration.GetConnectionString("Default");
```

Це `ConnectionStrings__Default`. Пароль брокера в Compose задається як `RabbitMqGraph__Password`.

Окремо з індексу прибрано каталоги `.sonarqube/` і `Core/.sonarqube/`: це робочі файли сканера, не код сервісу, і gitleaks позначав у них generic-api-key. Шлях додано в allowlist і в `.gitignore`. Сам токен аналізу в старих комітах історії лишається. Його треба відкликати в SonarQube і випустити новий. У цей звіт і в нові коміти він не копіювався.

Інші збіги до allowlist — фікстури, не бойові доступи: тестовий HS256 у `AuditApiFactory`, приклади в `SCALAR-GUIDE.md` і історичний `FRONTEND-HANDOFF.md`. Файл пастки в allowlist не входить.

## Порівняння

| Показник | Початковий стан | Контрольне порушення | Фінальний стан |
|---|---|---|---|
| Cognitive Complexity | 29 | поріг 15 перевищено | 7 |
| Cyclomatic Complexity | 37 | багато шляхів | 9 |
| Regression tests | покриття вже було | ризик змінити поведінку | PASS, 41 тест |
| Critical / High CVE | High: 1 | GHSA-v5pm-xwqc-g5wc | High: 0 |
| Secret scan status | — | FAIL, exit 1 | PASS, exit 0 |
| Git repository state | — | коміт пастки заблоковано | без цього секрету |

## Захист, близько п’яти хвилин

1. `git show 2e1b57b:lab3/evidence/complexity-before.txt` і `git show 0b9e6f6 -- Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs`. Сказати: цикломатична складність — число незалежних шляхів, когнітивна — та сама структура з штрафом за вкладеність. Extract Method і спільний підрахунок статусів прибрали дубль і вкладені цикли. Тести: журнал [regression-tests.txt](evidence/regression-tests.txt), 41 passed.
2. `powershell -File lab3/sca.ps1 -Phase after`. Показати High 0 проти High 1 у [sca-before.txt](evidence/sca-before.txt). Один кейс: транзитивний `Microsoft.OpenApi` 2.0.0, CVE-2026-49451, прямий пакет піднято до `Microsoft.AspNetCore.OpenApi` 10.0.11, зібралось, тести пройшли.
3. `powershell -File lab3/demo-secrets.ps1`. На екрані FAIL з файлом і правилом, коміт не з’являється в `git log -1`, потім PASS.
