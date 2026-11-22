---
owner: Babay
status: published
review_date: 2027-05-21
tags:
  - architecture
---

# Матриця покриття аудиторій

Звірка паспорта 2026-11-22. Прогалина, яку закрито цим паспортом: `README.md` посилався на відсутній `docs/USER-GUIDE.md` і не давав шляху від клону до карти сервісів. Шлях тепер у розділі Onboarding файлу README. Решта питань закрита SDD та ISD.

| Аудиторія | Ключові питання | Документ-відповідь | Статус |
|---|---|---|---|
| Новачок | Як запустити проєкт локально? | [README, Quick Start](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab11/README.md#quick-start) | покрито |
| Новачок | Що читати після клону, крім команди Docker? | [README, Onboarding](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab11/README.md#onboarding) | покрито |
| Розробник | З якими компонентами говорить мій модуль? | [SDD, компоненти](architecture/sdd.md#компоненти) | покрито |
| Розробник | Який контракт між сервісами, без читання C#? | [SDD, контракти](architecture/sdd.md#контракти-між-компонентами) | покрито |
| QA | Де описана очікувана поведінка для перевірок? | [SDD, контракти](architecture/sdd.md#контракти-між-компонентами), Scalar `/scalar/v1` | покрито |
| QA | Як підняти стенд, на якому це перевіряти? | [ISD, середовища](architecture/isd.md#топологія) | покрито |
| DevOps | Як розгорнути стек і як відкотити реліз? | [ISD, топологія і порядок](architecture/isd.md#порядок-підняття) | покрито |
| DevOps | Які RTO і RPO, і чи виконані вони зараз? | [ISD, RTO і RPO](architecture/isd.md#rto-і-rpo) | покрито |
| Бізнес | Що система робить і для кого? | [README, What is Relativa](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab11/README.md#what-is-relativa) | покрито |
| Бізнес | Яка поведінка вже є в продукті, а не в плані? | [README, Features](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab11/README.md#features) | покрито |
| Новачок | Де без токена побачити, які поля входять в операторський зріз? | [README, Onboarding](https://github.com/BabayVolohatyu/Relativa/blob/testing/lab11/README.md#onboarding), [SDD, operator digest](architecture/sdd.md#operator-digest) | покрито |
