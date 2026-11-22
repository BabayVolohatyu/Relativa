---
owner: Babay
status: published
review_date: 2027-05-21
tags:
  - architecture
---

# Архітектура

Рівень відповідає на питання «чому система влаштована так». Факти не копіюються на цю сторінку.

- [SDD](sdd.md) — контейнери, компоненти, фрагмент даних, контракти між сервісами.
- [ISD](isd.md) — порядок запуску, змінні, CI, RTO і RPO.
- [ADR-0001](adr/ADR-0001-shared-postgresql.md) — одна PostgreSQL. Статус Accepted.
- [ADR-0002](adr/ADR-0002-asynchronous-messaging.md) — outbox і RabbitMQ. Статус Accepted.
- [Покриття аудиторій](../audience-matrix.md).
- [Застарілі README сервісів](deprecated-service-readmes.md) — куди йти замість банерів deprecated.
- [Розділ API](../api/index.md) рендериться з OpenAPI, не з цього рівня.
- [Розробнику](../developer/index.md) — як зміна архітектури проходить рев'ю.

Кущ графа Obsidian, ті самі сторінки: [[architecture/sdd|SDD]] · [[architecture/isd|ISD]] · [[architecture/adr/ADR-0001-shared-postgresql|ADR-0001]] · [[architecture/adr/ADR-0002-asynchronous-messaging|ADR-0002]] · [[docs/api/index|API]] · [[docs/developer/local-setup|локальне середовище]] · [[docs/developer/contributing|долучення]] · [[maintenance]] · [[handover]] · [[audience-matrix]].
