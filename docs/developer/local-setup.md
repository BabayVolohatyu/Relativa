---
owner: Babay
status: published
review_date: 2027-02-20
tags:
  - ops
---

# Локальне середовище

Команди клонування, `.env` і `docker compose up --build -d` записані один раз, у `README.md`, розділ Quick Start. Тут лише те, чого в швидкому старті немає.

Гачок коміту вже вказує на `.githooks` (`core.hooksPath`). Він не пускає секрет (gitleaks) і метод C# із цикломатичною складністю вище 10 (lizard).

Перевірка трьох маршрутів шлюзу без решти стека:

```text
dotnet run --project Gateway/src/Relativa.Gateway/Relativa.Gateway.csproj
```

Процес слухає порт 8080. Далі, в іншому вікні:

```text
curl http://localhost:8080/health
curl http://localhost:8080/api/v1/operator/digest
```

`POST /auth/api/v1/auth/login` без контейнера Authentication не повертає 200: шлюз не має куди проксувати. Форма 200 і 401 описана в контракті за кодом `LoginRequestDto` / `LoginResponseDto` і `GlobalExceptionHandler` сервісу Authentication.

Порядок контейнерів повного стека — в [ISD](../architecture/isd.md).

Контрольний дефект strict-збірки: [сторінка, якої немає](missing-page.md).
