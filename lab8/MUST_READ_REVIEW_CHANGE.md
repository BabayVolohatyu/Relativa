# Перед захистом ЛР8

Числа і коміти вже в `lab8/evidence/` і в історії гілки `lab8`. Перед захистом перепиши своїми реченнями абзаци, які читатимуть як твої. Цифри не змінюй.

## 1. Проговорити CBO і LCOM

За плутанину на захисті знімають **2 бали**.

- CBO рахує, з якими чужими типами клас стикається: поля, бази, параметри, типи в `new` і приведеннях. Примітиви, `string`, `decimal`, `int`, `bool`, `DateTime`, `Guid`, `CancellationToken` не входять.
- LCOM тут шкала Хендерсона-Селлерса від 0 до 1. 0 означає, що методи ділять одні й ті самі поля. 1 означає, що кожен метод сидить на своєму полі і з сусідом по класу нічого не ділить.
- Це не Sonar LCOM4. У старому LCOM4 одиниця була добрим знаком. У цій роботі одиниця означає клас-мутант.
- `DealDesk`: CBO 16, LCOM 1. Після розрізу жоден стіл не має CBO вище 3 і LCOM вище 0.
- `DashboardService`: CBO 15, LCOM 0.782. Зачеплення на межі, але методи ще ділять контекст. Це не той розрізнений мутант.

## 2. Не сплутати два антипатерни

- God Object: один клас сам створює 16 сусідів. Зміна сигнатури `StageWeight.Weight` ламає два виклики всередині `DealDesk` (CS7036). Лікування: чотири столи і інтерфейси в конструкторі.
- Inheritance Hell: `DeskQuoteRule` має DIT 3 і PIM 21, на кожному рівні перекрито 11 методів. Зміна `QuoteRule.Status` дає CS0115 у `StageQuoteRule`. Лікування: `DeskQuote` тримає `QuoteMath` і `StageAdjustment` полями. DIT 1, override 0. Листове `Status` лишається 0.17 (0.15 + 0.02).

## 3. Що переписати своїми словами

Регламент знімає **3 бали**, якщо рефакторинг і вердикт у логу чату виглядають повністю чужими.

- чому LCOM 0.782 у дашборда не дотягує до мутанта, а LCOM 1 у `DealDesk` дотягує;
- чому валідатор має DIT 2 і PIM 0;
- чим шокова зміна сигнатури в сусіда відрізняється від зміни сигнатури в корені ієрархії;
- чому після композиції перевизначених методів нуль.

## 4. Живе демо

Гілка `lab8`, з кореня:

```text
git log -6 --oneline
dotnet test Graph/tests/Relativa.Graph.Integration.Tests/Relativa.Graph.Integration.Tests.csproj --filter FullyQualifiedName~DesignAudit
dotnet run --project lab8/metrics/Relativa.Lab8.Metrics.csproj -- --repo . --out lab8/out --snapshot inherit-pass
```

Очікування: 22 тести зелені, `DeskQuote` має DIT 1 і overridden 0, столи мають CBO не вище 3 і LCOM 0.

Червоні прогони не відтворюй, якщо не просять checkout: god-object FAIL це `107c73d`, inheritance FAIL це `f9d2b2c`. Логи лежать у `lab8/evidence/fail-god-build.txt` і `lab8/evidence/fail-inherit-build.txt`.

Sonar: `powershell -File lab8/pull-measures.ps1`, якщо в сесії є `SONAR_TOKEN` і сервер на `localhost:9000`. Ключі `class_complexity`, `lcom4`, `coupling_between_objects` сервер 26.10 відповідає помилкою. Числа CK і MOOD бере сканер, не дашборд.
