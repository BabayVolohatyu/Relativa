# Load tests (High Load Systems, Lab 5)

Declarative [k6](https://k6.io) scripts for the Relativa Graph service. No manual Postman/Swagger measurements are used.
Results, tables and the System Performance Baseline card: `high-load-systems/evidence/lab5/k6/COMPARISON.md` and the
"Load & Performance Baseline" section of the root `README.md`.

```
load-tests/lab5/
  lib/common.js          shared requests (readGraph, createEntity), measurement window, metrics
  scenario-a-read.js     Scenario A  READ-INTENSIVE      GET  /api/v1/graph?organizationId=1
  scenario-b-write.js    Scenario B  WRITE-INTENSIVE     POST /api/v1/workspaces/1/entity-graph/create
  scenario-c-mixed.js    Scenario C  COMPLEX WORKFLOW    read graph -> think -> create entity -> think
  staged-demo.js         staged ramp 10 -> 25 -> 50 -> 100 -> 200 VUs in ONE run (live demo), SCENARIO=A|B|C
```

## Model

* Closed model: `VUS` virtual users, each repeats its request and waits `THINK_MS` (500 ms; scenario C: 300 ms twice).
* A run = warm-up (separate 5 VU / 15 s run, discarded) + ramp `0 -> VUS` over `RAMP_S` (15 s, **not measured**) + hold
  `DURATION` (60 s, **measured**). Only requests finishing during the hold go into the `m_*` metrics the reports use.
* No thresholds: the scripts record statistics, they never "fail" a run.
* Entry point `BASE_URL` (default `http://localhost:8090`; inside the Docker network `http://relativa-graph-lb`),
  `USER_ID` (header `X-User-Id`, default 1), `ORG_ID` (default 1), `WORKSPACE_ID` (default 1).

## Environment (what the numbers were measured on)

Windows 10, Intel i5-8300H (4 cores / 8 threads), 7.9 GB RAM, Docker Desktop with 8 CPUs and about 4 GB for containers,
**no per-container CPU/RAM limits**. Stack: 3 Graph instances (.NET 10, Npgsql default pool of 100 per instance) behind
nginx 1.27 (Round Robin), PostgreSQL 16 (`max_connections=100`, `shared_buffers=128MB`), Redis 7 (Cache-Aside, TTL 60 s,
`maxmemory 0`), RabbitMQ 3.13, ML (Django, one consumer), Core (one consumer of `core.entity_graph.create`).
The load generator is the `grafana/k6` container on the same Docker network (it shares the same CPUs, see the report).
The full snapshot is in `high-load-systems/evidence/lab5/environment.txt`.

## Run

Scenario write paths need the Core container: `docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml up -d --no-build core`.

One measurement exactly as in the report (k6 in a container, clean state, cold cache, resource sampling):

```powershell
powershell -File high-load-systems/evidence/lab5/scripts/run-k6.ps1 -Scenario A -Vus 100 -OutDir scenario-a/vus-100 -Run 1
```

Live staged demo (about 4 minutes, prints the ladder table):

```powershell
powershell -File high-load-systems/evidence/lab5/scripts/run-staged.ps1 -Scenario A
```

Plain k6, from the repo root (needs k6 installed; the entry point must be reachable from where k6 runs):

```powershell
k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" -e VUS=50 -e DURATION=60s -e BASE_URL=http://localhost:8090 `
    --summary-export=summary.json load-tests/lab5/scenario-a-read.js
```

Write scenarios create entities with `first_name = Lab5WriteTest`; `lab5-lib.ps1` (`Reset-TestData`) deletes them and the
audit rows they produce. Never leave them in the database between measurements: they slow later runs down.
