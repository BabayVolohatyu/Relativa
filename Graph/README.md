# relativa-graph

> **Deprecated as an operational description (documentation audit 2026-11-22).** The text below still calls the SignalR hub an empty stub. Graph query and the dashboard are implemented. Design: [docs/architecture/sdd.md](../docs/architecture/sdd.md). Run and recovery: [docs/architecture/isd.md](../docs/architecture/isd.md).



Сервіс графа на **ASP.NET Core 10**. **Solution** у корені; **Web API** у `src/Relativa.Graph/`.

## Порт

- **8083**

## Стек

- **SignalR** — хаб `GraphHub` з мапінгом на **`/hubs/graph`** (порожня заглушка `OnConnectedAsync`).

## Подальша робота

- Рекурсивні CTE-запити, динамічна RBAC-фільтрація, live-оновлення графа через SignalR, інтеграція ML-скорів (relativa-ml).

## Команди

```bash
dotnet restore Relativa.Graph.sln
dotnet build Relativa.Graph.sln
dotnet run --project src/Relativa.Graph
```

## Gateway

Клієнти потрапляють сюди лише через **relativa-gateway** (маршрут YARP `/graph/...` → upstream 8083). Для WebSocket/SSE можуть знадобитися додаткові налаштування YARP.
