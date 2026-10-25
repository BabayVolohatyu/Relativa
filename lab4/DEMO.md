# Лабораторна 4 — сценарій захисту

Клієнт API — Gateway Scalar: http://localhost:8080/scalar/v1

Стек уже має міграцію `AddPrivacyEngineering`. Лабораторні облікові записи:

| Користувач | Id | Email | Пароль |
|---|---:|---|---|
| Суб'єкт | 91001 | ada.lovelace@example.test | synthetic-password-not-real |
| Інший | 91002 | grace.hopper@example.test | synthetic-password-not-real |

Адміністратора `admin@relativa.com` (id 1, пароль `Demo1234!`) не анонімізувати. У Scalar в поле Bearer Token вставляється лише `accessToken`, без префікса `Bearer`.

## Крок 1. Логи

1. Увійти як `ada.lovelace@example.test`.
2. Відкрити `POST /auth/api/v1/auth/privacy/log-probe`. Тіло вже заповнене синтетичними email, телефоном, паролем і токеном. Send.
3. У логу контейнера видно замасковані ідентифікатори і `[REDACTED]` замість секретів:

```text
docker logs relativa-auth --tail 50
```

4. Тест:

```text
dotnet test Authentication/tests/Relativa.Authentication.Application.Tests/Relativa.Authentication.Application.Tests.csproj --filter FullyQualifiedName~PrivacyLogFormatter
```

## Крок 2. Експорт

1. З тим самим токеном відкрити `GET /auth/api/v1/auth/users/{id}/personal-data`. Приклад `id` — 91001.
2. У відповіді є `profile`, `settings`, `emails`, `externalLogins`, `activity`, `consents`. Секретів немає, вони перелічені в `excluded`.
3. Не змінюючи токен, поставити `id` 91002 і надіслати знову. Відповідь 404 `Resource not found.` без полів профілю.

## Крок 3. Анонімізація

Перед запитом:

```text
docker exec relativa-postgres psql -U relativa -d relativa -c "SELECT id, email, phone, first_name FROM users WHERE id = 91001; SELECT address FROM user_emails WHERE user_id = 91001;"
```

Потім `POST /auth/api/v1/auth/users/91001/anonymize`. Повторити SQL. Email стає `user-91001@anonymized.invalid`, телефон зникає, рядок користувача лишається. Повторний Send повертає `alreadyAnonymized: true` і не відновлює дані.

Якщо цей крок уже виконано на захисті, для повторного прогону потрібен новий суб'єкт: анонімізація незворотна.

## Крок 4. Згода

На користувачі, який ще не анонімізований:

1. `POST /auth/api/v1/auth/users/91001/marketing-email` з тілом `{ "purpose": "MARKETING_EMAIL" }` — 403, рядок у `marketing_dispatches` не з'являється.
2. `POST .../consents/MARKETING_EMAIL/grant` з `{ "policyVersion": "2026-10-01", "source": "settings-ui" }`.
3. Повторити marketing-email — 200, один рядок у `marketing_dispatches`.
4. `POST .../consents/MARKETING_EMAIL/revoke`.
5. Повторити marketing-email — знову 403, кількість рядків не змінюється.
6. Той самий grant не дозволяє `purpose` `OPTIONAL_ANALYTICS`.

Тест сценарію:

```text
dotnet test Authentication/tests/Relativa.Authentication.Application.Tests/Relativa.Authentication.Application.Tests.csproj --filter FullyQualifiedName~PrivacyIntegrationTests.Consent
```
