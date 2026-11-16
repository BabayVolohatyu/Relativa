# **ЛАБОРАТОРНА РОБОТА № 10 Тема: Фінальна оптимізація продуктивності (Final Optimization) та Захист архітектурного рішення (Architecture Review)** 

#### **1. Мета роботи** 

Завершити розробку та проведення комплексного інженерного аналізу розподіленої високонавантаженої системи. Здійснити фінальний контрольний прогін навантажувальних тестів для порівняння з початковим профілем продуктивності (Performance Baseline з Лабораторної роботи № 5), провести атрибуцію системних покращень (Attribution of Improvements), формалізувати межі масштабованості (Scaling Limits), визначити єдині точки відмови (Single Points of Failure — SPOF), а також обґрунтувати компроміси консистентності (Consistency Trade-offs) та інженерну вартість складності системи (Cost of Complexity). 

По завершенню роботи студенти повинні вміти: 

- проводити сквозний аналіз проходження запиту (Request Flow) через усі рівні розгортання розподіленої системи; 

- аргументовано зіставляти первинний та фінальний профілі продуктивності (Baseline vs Final Verification); 

- ідентифікувати конкретний архітектурний компонент, що забезпечив ключовий приріст продуктивності (Attribution of Improvements); 

- аналізувати архітектуру на наявність структурних обмежень та єдиних точок відмови (SPOF Analysis); 

- оцінювати компроміси між швидкістю, відмовостійкістю та консистентністю даних (CAP/PACELC Trade-offs); 

- захищати комплексне System Design рішення перед інженерною комісією. 

## **2. Завдання та етапи виконання** 

### **2.1. Специфікація актуальної фінальної архітектури та Request Flow** 

1. Розробити підсумкову деталізовану архітектурну схему (C4 Model / Container Level), що відображає лише фактично реалізовані компоненти: Client, Load Balancer, Application Instances, Distributed Cache (Redis), Shard Router, Shards (Primary/Replica). 

2. Для одного сквозного бізнес-сценарію сформулювати повний шлях проходження запиту (Request Flow) із зазначенням потенційних затримок (Latencies), точки відмови (Failure Modes) та захисних механізмів (Fallbacks) на кожному кроці. 

### **2.2. Повторне тестування та фінальне порівняння (Baseline vs Final Comparison)** 

На тотожній конфігурації тестового середовища із збереженням профілю навантаження з 

Лабораторної роботи № 5 виконати фінальний прогін та скласти підсумкову порівняльну таблицю: 

|Метрика<br>продуктивності|Початковий стан (Lab<br>5 Baseline)|Фінальний стан (Final<br>Architecture)|Приріст / Оптимізація<br>(%)|
|---|---|---|---|
|**Stable Throughput**<br>**(RPS)**|—|—|—|
|**p50 Latency**|—|—|—|
|**p95 Latency**|—|—|—|
|**p99 Tail Latency**|—|—|—|
|**Error Rate at**<br>**Saturation (%)**|—|—|—|
|**Saturation Threshold**<br>**(Target VUs)**|—|—|—|



### **2.3. Атрибуція покращень та межі масштабованості (Scaling Limits)** 

1. Здійснити **Attribution of Improvements** — чітко зв'язати кожне покращення з конкретною оптимізацією (наприклад, оптимізація p95 на читання → Redis Cache; зростання Throughput → Horizontal Scaling + Database Replication; ліквідація сплесків p99 → Stampede Protection). 

2. Визначити **поточні межі масштабованості**: назвати компонент системи, який першим досягає насичення при зростанні навантаження у 2–5 разів від поточного максимуму. 

### **2.4. Ревізія відмовостійкості, SPOF та компромісів консистентності** 

1. **Failure Scenarios Review:** Продемонструвати поведінку фінальної системи при симуляції аварій (падіння одного backend instance, недоступність Redis, втрата Read Replica). Зафіксувати рівень деградації (Graceful Degradation). 

2. **SPOF Analysis:** Визначити наявні єдині точки відмови (Single Points of Failure — наприклад, Single Load Balancer, Single Primary DB Node) та обґрунтувати, чому вони не були усунені (Engineering Trade-offs). 

3. **Consistency Trade-offs:** Чітко класифікувати рівні консистентності в системі (де допускається Eventual Consistency / Stale Read, а де вимагається Strong / Read-YourOwn-Writes Consistency). 

4. **Cost of Complexity Analysis:** Проаналізувати інженерну вартість ускладнення системи та відповісти на питання: _«Які компоненти/шари можна вилучити, якби навантаження зменшилося у 10 разів?»_ 

### **2.5. Специфікація Final Engineering Summary** 

Підсумувати результати проєкту у фінальному паспорті системи: === FINAL SYSTEM ENGINEERING SUMMARY === Architecture Style:    [e.g., Stateless Microservices / Modular Monolith with Data Sharding] 

Primary Workload Type: [Read-heavy / Write-heavy / Mixed Workflow] 

Stable Throughput:     [Target RPS] p95 / p99 Latencies:   [Values in ms] Saturation Point:      [Max VUs threshold] Main Bottleneck:       [System component limiting next scaling tier] Resilience Strategy:   [Circuit Breakers, Single-Flight, Primary Fallback] Consistency Model:     [Eventual for Reads, Strong for Transactional Writes] Identified SPOFs:      [Known Single Points of Failure] Next Scaling Step:     [Next architectural improvement] 

## **3. Вимоги до Git-репозиторію та підсумкової документації** 

У репозиторії проєкту мають бути сформовані підсумкові матеріали у файлі README.md та директорії /docs: 

- Фінальна архітектурна схема (C4 Container Diagram); 

- Опис сквозного Request Flow з картуванням затримок; 

- Порівняльна таблиця результатів (Baseline vs Final Verification); 

- Аналітичний розділ щодо SPOF, Consistency Trade-offs та Cost of Complexity; 

- Оформлений **Final System Engineering Summary**. 

## **4. Порядок фінального захисту та критерії оцінювання** 

### **Процедура захисту:** 

1. **Презентація System Design:** Пояснення фінальної архітектури та проходження запиту через усі компоненти. 

2. **Live Load Testing:** Запуск навантажувального тесту у реальному часі та демонстрація досягнення заявлених метрик Stable RPS, p95/p99 затримок та точки насичення. 

3. **Live Failure Scenario:** Симуляція збою одного з інфраструктурних вузлів та демонстрація поведінки системи під навантаженням. 

4. **Комплексний інженерний захист:** Аргументація прийнятих рішень, аналіз SPOF, компромісів консистентності та захист зон відповідальності кожним членом команди. 

### **Критерії оцінювання:** 

- **Глибина розуміння системи:** Здатність пояснити поведінку будь-якого компонента під навантаженням. 

- **Аргументованість порівняльного аналізу:** Наявність підтверджених даних про ефект кожної оптимізації. 

- **Інженерна зрілість:** Об'єктивна оцінка обмежень системи, її SPOF та компромісів складності. 

