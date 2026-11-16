# Лабораторна робота №4

Privacy Engineering та реалізація вимог GDPR у програмних системах

Проєкт: Relativa. Контролі додані в сервіс Authentication. Персональні дані акаунта вже жили в `users`, `user_emails`, `user_settings` і в JSON аудиту. CRM-картки в `entity_property_value` до цього суб'єкта не входять: там дані контрагентів, а не облікового запису.

## 1. Характеристика системи та інвентаризація

Стек: .NET 10, ASP.NET Core minimal APIs, EF Core, PostgreSQL 16, Serilog, JWT Bearer. Автентифікація — `POST /api/v1/auth/login`, claim `sub` містить id користувача. Сховище автентифікації — [`AuthDbContext`](../Authentication/src/Relativa.Authentication.Infrastructure/Data/AuthDbContext.cs).

| Категорія | Де лежить | Експорт | Логи |
|---|---|---|---|
| Ім'я, email, телефон, дата народження | `users` | секція `profile` | email і телефон маскуються |
| Додаткова адреса | `user_emails` | секція `emails`, без verification token | маскується |
| Зовнішній ідентифікатор | `user_external_logins` | `provider` і `subject` | секретів немає |
| Налаштування | `user_settings.locale` | секція `settings` | не логується |
| Історія | `user_audit_log` | `action`, `fieldName`, `changedAt` | старі значення чистяться під час анонімізації |
| Згода | `user_consents`, `user_consent_events` | секція `consents` | лише id і результат |
| Секрети | password, reset token, verification token, 2FA, backup-code hash | ніколи; перелік у `excluded` | завжди `[REDACTED]` |

М'яке архівування `ArchiveUserAsync` лишилось для поточного продукту. Воно лише ставить `is_archived` і раніше ще копіювало email в аудит. Для права на видалення це не підходить: початкові ідентифікатори залишаються, а запис можна відрізнити від інших. Окремий workflow анонімізації це прибирає. Подія `user_archived` більше не пише email.

Контрольні значення синтетичні: `ada.lovelace@example.test`, `+15555550123`, `synthetic-password-not-real`, `synthetic-token-not-real`. Другий користувач — `grace.hopper@example.test`.

## 2. Безпечне логування

Єдиний вихід — [`PrivacyLogTextFormatter`](../Authentication/src/Relativa.Authentication.Infrastructure/Logging/PrivacyLogTextFormatter.cs) на консолі і на файлі в [`Program.cs`](../Authentication/src/Relativa.Authentication/Program.cs). Обидва попередні sink-и без форматера прибрані. Форматер обробляє текст повідомлення, вкладені властивості і `Exception.ToString()` до серіалізації, тож JSON лишається валідним. Correlation id, числовий id і назва операції не чіпаються.

Той самий пробний запис до захисту:

```text
privacy log probe correlation 11111111-1111-1111-1111-111111111111 Email=ada.lovelace@example.test Phone=+15555550123 Password=synthetic-password-not-real Token=synthetic-token-not-real
```

Після форматера в рядку є `a***@example.test`, `***23`, `[REDACTED]` і correlation id. Повних email, телефону, пароля і токена немає. Негативний випадок кладе ті самі значення у вкладений об'єкт і в текст винятку `token=... email=... phone=...`. Тест падає, якщо хоч один оригінал лишився.

Команда і результат — [evidence/privacy-tests.txt](evidence/privacy-tests.txt). Позитивний і негативний тести пройшли. Тіло запиту Serilog request logging не пише.

Демонстраційний вхід — `POST /api/v1/auth/privacy/log-probe`. Логін пароль не логує: у нього немає телефону, і успішний шлях не повинен починати писати секрет лише заради демо.

## 3. Експорт персональних даних

`GET /api/v1/auth/users/{id}/personal-data`. Через Gateway шлях має префікс `/auth`. Ендпоінт бере `sub` і передає його разом із id з шляху. Сервіс порівнює їх ще раз. Чужий id і відсутній id дають однаковий 404 `Resource not found.` без полів профілю.

Відповідь, `schemaVersion` 1, час у UTC:

```json
{
  "schemaVersion": 1,
  "meta": { "schemaVersion": 1, "generatedAt": "2026-10-25T15:00:00Z", "subjectId": 91001, "correlationId": "..." },
  "profile": { "id": 91001, "firstName": "Ada", "lastName": "Lovelace", "email": "ada.lovelace@example.test", "phone": "+15555550123" },
  "settings": { "locale": "uk" },
  "emails": [{ "address": "ada.alias@example.test", "isVerified": true, "source": "manual" }],
  "externalLogins": [{ "provider": "google", "subject": "synthetic-subject-ada" }],
  "activity": [{ "action": "user_profile_updated", "fieldName": "first_name" }],
  "consents": [],
  "excluded": ["password", "passwordResetToken", "emailVerificationToken", "twoFactorSecret", "twoFactorMasterCodeHash", "backupCodeHash", "verificationToken"]
}
```

`profile` зібраний з `users`, `settings` з `user_settings`, `emails` з `user_emails`, `externalLogins` з `user_external_logins`, `activity` з `user_audit_log`, `consents` з `user_consents`. Порожня категорія — `[]` або `locale: null`, ключ не зникає. Журнал експорту містить дію, id актора, id суб'єкта, результат і correlation id. Тест перевіряє, що сирий email у цей рядок не потрапляє.

## 4. Анонімізація

`POST /api/v1/auth/users/{id}/anonymize`. Одна транзакція. Повторний виклик бачить `anonymized_at` і нічого не змінює.

| Сутність | Дія | Чому |
|---|---|---|
| `users` | ANONYMIZE | Рядок лишається, бо на нього посилаються членства і CRM поза контекстом Auth. Ім'я стає Erased Subject, email — `user-{id}@anonymized.invalid`. Це не псевдонім: таблиці зворотної відповідності немає. |
| `user_emails` | DELETE | Адреса і verification token. Унікальний індекс на адресу. |
| `user_external_logins` | DELETE | Subject провайдера знову прив'язує людину. |
| `user_backup_codes` | DELETE | Хеші секретів. |
| `user_settings` | ANONYMIZE | Locale скидається на `en`. |
| `user_audit_log`, `audit_outbox` | ANONYMIZE | Старі й нові значення обнуляються, початкові рядки вичищаються. Подія `user_anonymized` пише лише результат і correlation id. |
| `user_consents`, `user_consent_events`, `marketing_dispatches` | RETAIN | Немає прямого ідентифікатора, лише id уже анонімного рядка. Це модель підзвітності, не юридичний строк зберігання. |
| Членства і CRM | SKIP | У контексті Auth їх немає. За правилом 3NF ім'я й email туди не копіюються. Зовнішній ключ лишається цілим, бо рядок користувача не видаляється. |

Інтеграційний тест готує пов'язаний набір, перевіряє зникнення початкових значень, збереження згоди і dispatch, цілість рядка, повторний запуск, відмову чужому актору і відкат, коли `SaveChanges` кидає виняток.

## 5. Згоди

Мети: `MARKETING_EMAIL` і `OPTIONAL_ANALYTICS`. Згода однієї не відкриває іншу. Поточний стан — `user_consents`, історія переходів — `user_consent_events` (`policy_version`, `source`, `occurred_at`). Повторний GRANT тієї самої версії і повторний REVOKE не додають подію і не зсувають час.

`POST .../consents/{purpose}/grant` і `.../revoke` доступні лише власнику. Джерело — лише `settings-ui` або `import`.

[`ConsentPolicyGate`](../Authentication/src/Relativa.Authentication.Application/Services/ConsentPolicyGate.cs) викликається в `SendAsync` безпосередньо перед записом `marketing_dispatches`. Немає кешу і черги, тож відкликання діє на наступний виклик. Якщо згоди немає, її відкликано або версія політики не `2026-10-01`, відповідь 403 `consent_required` і рядок не створюється. Логін, профіль і експорт цей шлюз не викликають.

Тест проходить послідовність: початковий DENY без рядка dispatch, GRANT, один dispatch, ізоляція іншої мети, REVOKE, повторний DENY без нового рядка.

## 6. Висновок

Санітайзер закриває витік у журнал навіть тоді, коли значення передали вкладеним об'єктом або текстом винятку. Експорт закриває IDOR і надлишкову відповідь: шлях сам по собі не дає даних, секрети в контракт не входять. Анонімізація прибирає прямі ідентифікатори з охоплених таблиць і не ламає зовнішні ключі. Шлюз згоди реально зупиняє розсилку після відкликання.

Код не визначає законну підставу обробки, строк зберігання і те, чи залишковий числовий id ще є персональними даними в юридичному сенсі. Старі файли логів сервіс не переписує: форматер лише не пускає нові значення. Це організаційний контроль строку життя журналів.
