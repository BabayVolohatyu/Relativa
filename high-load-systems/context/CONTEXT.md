# High Load Systems: agent handoff

Read this first if you are an agent working on a "High Load Systems" lab in this repo. Update it at the end of every lab (even if the lab needed no code), keeping the per-lab log current.

## 1. Course and deliverables

University course "High Load Systems" (a different course from the earlier labs under `testing-labs/`, `devops/`, `defence/`, `lab-desc/` at repo root, which you can ignore). Lab descriptions (Ukrainian) are in `high-load-systems/description/`. Work happens on branch `high-load-systems/labN`.

The codebase (Relativa, .NET microservices) is too large to cover entirely. Each lab: **pick the services expected to carry the largest load** (Graph is the heaviest) and apply the lab's pattern there. If a requirement is already met, still fill defence and evidence.

Every lab must produce:

| Deliverable | Location | Purpose |
|---|---|---|
| Defence plan | `high-load-systems/defence/labN.md` | Everything the student needs to defend orally: what was done, why, what result, theory Q&A, risks, run commands. Language: **Ukrainian** (matches earlier defence docs), technical terms in English. |
| Evidence | `high-load-systems/evidence/labN/` | Proofs: logs, scripts, before/after outputs, k6 stats. |
| k6 stats | `high-load-systems/evidence/labN/k6/pre-lab/` and `.../post-lab/` | Script + `summary.json` + console output, run before and after the change. **Stats only: no thresholds, no expectation of good numbers.** Report honestly, never claim an improvement that is not there. |
| k6 comparison | `high-load-systems/evidence/labN/k6/COMPARISON.md` | Human-readable table: test input, pre vs post stats, % change and % improvement (rule below). |
| Context | `high-load-systems/context/` (this file) | Guidelines for the next agent. |

**Rule: every lab must also contain `evidence/labN/k6/COMPARISON.md`**, a human-readable pre-lab vs post-lab comparison. Required content:

1. **Test input table**: tool/version, executor, VUs (start/peak/stages), target rate (or "not set, closed loop"), think time, request(s) and headers, response size, timeout, thresholds, data set.
2. **What differed between the runs**: code, topology/instance count, `BASE_URL`, extra components, traffic split per instance.
3. **Results table** with columns `Metric | Pre-lab | Post-lab | Change % | Improvement % | Verdict`: total requests, throughput, latency avg/min/median/p90/p95/max, TTFB avg/p95, iteration duration avg/p95, failed requests. `Change % = (post - pre) / pre * 100`; `Improvement %` flips the sign for lower-is-better metrics, so positive always means better. Negative improvements must be shown as they are. **Data sizes (data received/sent) must be written as GB + MB in decimal units, e.g. `2GB 567MB` (use `0GB 242MB` when under 1 GB), never as raw bytes.**
4. **How to read it**: short, honest interpretation (why the numbers moved or did not; what was not profiled; single-run noise caveat).

Generate the results table with `high-load-systems/evidence/lab2/k6/compare-summaries.ps1 -Pre <pre summary.json> -Post <post summary.json>` and paste it in; write sections 1, 2 and 4 by hand. Use `evidence/lab2/k6/COMPARISON.md` as the template. Link or summarize it from `defence/labN.md`.

Additional k6 rules (learned in Lab 2):

- **Run each side at least twice** and include a "run-to-run noise" table (same setup, run 1 vs run 2) in `COMPARISON.md`. A single run is not evidence: in Lab 2 the noise (up to about 29% on p95) was bigger than the pre/post difference, and the two runs even pointed in opposite directions.
- **Measure "pre-lab" on the genuinely original code**, not on the refactored code with a feature switched off. Build the original image from a git worktree of the original commit: `git worktree add --detach $env:TEMP\relativa-orig HEAD`, `docker build -t relativa-graph-orig -f Graph/Dockerfile .` there, then run the base stack with a temporary override file containing `services: { graph: { image: relativa-graph-orig } }`. Remove the worktree afterwards (`git worktree remove --force`).
- Keep earlier runs (`summary.run1.json`, `k6-output.run1.txt`) instead of overwriting them.

**Rule: evidence must match the final code.** Whenever code changes after evidence was recorded (for example because of the complexity gate below), rebuild the images, re-run every "after" script and the k6 post-lab run, regenerate `COMPARISON.md`, and update `defence/labN.md`, `FOR-ME-*` and this file with the new numbers. Do not leave numbers from an older build in any document.

**Rule: every C# change must pass the repository's pre-commit complexity gate.** `.githooks/pre-commit` runs gitleaks and then `python -m lizard -C 10 -L 99999 -a 99999 -l csharp <staged .cs files>`; any method with cyclomatic complexity above 10 rejects the commit. Important details:

- The hook checks the **whole staged file**, not only your diff. If you touch a file that already contains methods above 10, you must refactor those methods too (Lab 2: the first commit was rejected because `WorkspaceDashboardService.cs` had five old methods at 12 to 37).
- Lizard counts `if`, `for`, `foreach`, `while`, `case`, `catch`, `&&`, `||`, `??`, `?.`, the `?` of `?:` and of nullable types such as `int?`. Lambdas and local functions count toward the enclosing method. Pattern `is "a" or "b"` is not counted.
- How to fix: extract small private methods (a `Prop(props, id, name)` style helper removes most `?.`/`??` chains), turn nested lambdas into named methods, move per-item logic out of loops, use small records for intermediate results. Keep behavior identical (same order of DB/ML/Redis calls) and re-run the Graph integration tests.
- Check before finishing, with the same arguments as the hook: `python -m lizard -C 10 -L 99999 -a 99999 -l csharp -w <changed .cs files>` (no output = pass). Changed files: `git diff --name-only HEAD -- '*.cs'` (skip `Migrations`, `*.Designer.cs`, `bin`, `obj`).

Evidence layout convention used in Lab 2 (reuse it): `evidence/labN/{k6/pre-lab, k6/post-lab, before, after, scripts}`; raw logs are saved with `Out-File` (not `Tee-Object | Select-Object -First`, which truncates).

The student may ask for a personal plain-language explanation in the evidence folder for a specific lab (done for Lab 2: `evidence/lab2/FOR-ME-stateless-explained.md`, English). Only do that when asked.

If something is genuinely uncertain, ask the student before implementing (they prefer questions to guesses). Be explicit about deviations from the plan in the final message.

**Git note:** `high-load-systems/`, `testing-labs/` and `devops/` are listed in the root `.gitignore`, so everything in them is untracked and will not show in `git status`. Do not "fix" this, and do not force-add these folders unless the student asks.

## 2. Environment

- Windows 10, **PowerShell 5.1** (no `??`, no `&&`-chaining assumptions in scripts; use `.ps1`, not `.sh`). No node installed. dotnet SDK 10.0.x. Docker Desktop engine is up. k6 v2.x is installed.
- **Everything infrastructural runs in containers** (Redis, nginx, Postgres, RabbitMQ). The student does not have Redis installed and does not want it installed.
- Docker Desktop can wedge (HTTP 500 / hangs) when the Graph integration tests (Testcontainers) run at the same time as a `docker compose build`. Do not run them concurrently. Recovery: kill hung compose processes, `docker desktop restart`.
- Docker Desktop is limited to about 4 GB of RAM here, and `relativa-sonarqube` (about 1 GB, the student's own container) usually runs. Before running the Graph integration tests, stop the lab stack (`docker compose -f docker-compose.yaml -f docker-compose.lab2.yml down`). The full test run takes about 4 to 6 minutes (170 tests). A run right after a Docker restart gave 7 spurious failures; the same run again gave only the 2 known ones.
- Docker Desktop's host port forwarding can hang while `docker` commands still work (symptom: `curl http://localhost:8081/health` times out, `docker ps` is fine). Fix: `docker desktop restart`, then bring the stack up again. When bringing up the lab stack, you do not need everything: `docker compose -f docker-compose.yaml -f docker-compose.lab2.yml up -d postgres rabbitmq redis migration graph graph-2 auth auth-2 graph-lb ml mailhog`.
- `mailhog` must be running for `POST /api/v1/support/contact` to return 204 (the endpoint sends an email after the rate limiter; without an SMTP server it returns 500, although the rate-limit counter is still consumed).
- The compose file is `docker-compose.yaml` (not `.yml`).

## 3. Architecture quick map

.NET 10 microservices behind a YARP Gateway, PostgreSQL 16, RabbitMQ 3.13, Docker Compose.

| Service | Role | Direct port (base compose) |
|---|---|---|
| Gateway (YARP, JWT) | Routes `/graph/**`, `/auth/**` ... to services | 8080 |
| Authentication | Login, JWT, `/api/v1/auth/me`, support contact (rate-limited), audit outbox | 8081 |
| Core | Core domain, SignalR `CoreHub`, `IMemoryCache` for entity types | see compose |
| Graph | Graph (EAV nodes/edges), dashboards, SignalR `GraphHub` (`/hubs/graph`), RabbitMQ consumers, ML RPC | 8083 |
| ML (Django) | Scoring over RabbitMQ RPC | n/a |
| Audit, Migration | Audit consumer, DB migrations | n/a |
| Client (Vue) | `Client/src/api/graphHub.ts` etc. | n/a |

Seed data: login `admin@relativa.com` / `Demo1234!` (user id 1, org_owner of organization 1; workspaces 1 and 3). RabbitMQ `relativa`/`relativa`, management on 15672. For direct (non-gateway) calls to Graph use header `X-User-Id: 1`. Largest test graph: `GET /api/v1/graph?organizationId=1` (183 nodes, 291 edges).

## 4. How to run the stack

```powershell
# base / pre-lab stand (single instances)
docker compose up -d postgres rabbitmq migration graph ml

# Lab 2 topology (override file on top of the untouched base file)
docker compose -f docker-compose.yaml -f docker-compose.lab2.yml up -d --build

# Lab 3 topology (3 Graph + nginx with 3 upstreams); extra overlays: -slow, -cpulimit, -poolcap, -haproxy (see Lab 3 log)
docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml up -d --build

# Lab 4: SAME topology and files as Lab 3 (the cache needs no new container). Start Core too if you want to demo writes:
#   ... up -d --no-build core        and  docker restart relativa-graph-lb  after rebuilding Graph images
```

Lab 2 topology ports: nginx `graph-lb` 8090 (round-robin), graph-1 8083, graph-2 8085, auth-1 8081, auth-2 8087. Redis is internal-only (`relativa-redis`, `redis:7-alpine`, no persistence). Convention: **do not edit the base compose file; add `docker-compose.labN.yml` overrides** using `extends` (use `!override` when you must replace a list such as `ports`).

k6 run (from repo root; `-q` avoids progress spam in the log):

```powershell
k6 run -q --summary-export=high-load-systems/evidence/lab2/k6/post-lab/summary.json high-load-systems/evidence/lab2/k6/post-lab/graph-load-test.js
```

The Lab 2 k6 script is a reusable template for later labs (30→50 VUs, 2 min, no thresholds, per-instance counters read from the `X-Instance-ID` response header; k6 canonicalizes header names, so look it up case-insensitively).

## 5. Lab log

### Lab 1
Not done in this repo/branch for this course (no `defence/lab1.md` for it was produced here). If a future agent is asked to do it, follow section 1.

### Lab 2: Stateless Architecture (done)

Goal: audit and externalize in-process state, run ≥2 instances behind a non-sticky balancer, prove cross-instance consistency and instance-loss behavior.

What was found and fixed (each reproduced on the ORIGINAL code with 2 instances, then proved fixed):

| State | Where | Fix | Before → after |
|---|---|---|---|
| Rate-limit counters | Auth `MemoryEmailRateLimiter` | `RedisEmailRateLimiter` (Lua `INCR`+`PEXPIRE`, fail-closed) | 10 → 5 accepted (limit 5) |
| ML-recalc cooldown | Graph `WorkspaceDashboardService` (`IMemoryCache`) | `IDistributedCache` → Redis | 2 → 1 job enqueued |
| SignalR groups | Graph `GraphHub` | Redis backplane (`AddStackExchangeRedis`, channel prefix `relativa-graph`) | 10/20 → 20/20 events |
| SignalR negotiate affinity | `Client/src/api/graphHub.ts` | `skipNegotiation: true` + WebSockets | 2/10 connect (8 fail) → works via nginx |

Other changes: `X-Instance-ID` response header (env `INSTANCE_ID`, fallback machine name) in Graph and Auth; `Redis:ConnectionString` in both `appsettings.json` (empty = local fallback: `AddDistributedMemoryCache`, `MemoryEmailRateLimiter`); `docker-compose.lab2.yml`; `infra/nginx/graph-lb.conf`; 5 Graph test files switched to `MemoryDistributedCache`; `WorkspaceDashboardService` refactored into small methods (max cyclomatic complexity 9) to pass the pre-commit gate (see the rule in section 1). Pinned versions: `StackExchange.Redis` 2.13.23 in Auth (3.x gives NU1605), Graph Redis packages 10.0.15.

Evidence: `evidence/lab2/` (see its `k6/COMPARISON.md`, `scripts/`, `before/`, `after/`, `k6/`, `signalr-backplane-test.cs`, `FOR-ME-stateless-explained.md`). Defence: `defence/lab2.md`.

k6 (informational, two runs per side, final code; full tables in `evidence/lab2/k6/COMPARISON.md`): run 2 headline: 1 instance (original code) 30.44 req/s, avg 859 ms, p95 941 ms; 2 instances behind nginx 31.40 req/s, avg 821 ms, p95 910 ms; 0 failures; traffic split 1884/1886. Run 1 pointed the other way (29.85 vs 28.35 req/s). Run-to-run noise (up to about 29% on p95) is larger than the pre/post difference, so **there is no measurable gain**: the closed-loop test is latency-bound (~765 ms floor per request) and one instance is not saturated. Root cause of the 765 ms is unprofiled. If a later lab is about performance, start there (suspects: ML RPC round trip with 200 ms retry budget, DB query, EAV graph assembly).

Known residual risks (documented in the defence): non-atomic cooldown (use `SET NX`), Auth `AuditOutboxDispatcher` has no row locking so two instances can double-publish (consumers dedupe), Core still has an in-process `CoreHub` and `IMemoryCache` (needs a backplane if scaled), ephemeral DataProtection keys, Gateway has one Graph destination in compose, Redis is a single node, 2 of 170 Graph integration tests (`GraphDataServiceTests.BuildGraphAsync_MlClientThrows*`) fail and are unrelated: they fail identically on the original commit (verified in a git worktree); `GraphDataService` has no try/catch around the ML client. Final run on the refactored code: 168 passed, 2 failed.

### Lab 3: Horizontal Scaling and Load Balancing (done)

Goal: pool of 3 Graph instances behind one entry point, algorithm comparison (Round Robin vs Least Connections), `/health`, fault tolerance, scale-out analysis. Most of 2.1/2.2 was already true after Lab 2; Lab 3 added graph-3, the `/health` endpoint, new nginx configs, experiments and docs.

Code/config changes: Graph `Program.cs` got `AddHealthChecks().AddDbContextCheck<GraphDbContext>("postgres")` + `MapHealthChecks("/health")` + `ARTIFICIAL_DELAY_MS` middleware (async delay, 0/unset = no effect). NuGet `Microsoft.Extensions.Diagnostics.HealthChecks.EntityFrameworkCore` **10.0.5** (10.0.15 gives NU1605 in the Graph test project, which pins EF Core 10.0.5). Files: `infra/nginx/graph-lb-lab3-{rr,lc}.conf`, `docker-compose.lab3.yml`, `-lab3-slow.yml` (graph-2 +500 ms), `-lab3-cpulimit.yml` (1 CPU per Graph), `-lab3-poolcap.yml` (Npgsql `Maximum Pool Size=30`), `-lab3-haproxy.yml` + `infra/haproxy/graph-lb.cfg` (active health check, extra). Compose files stack: `-f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml [-f ...]`. Ports: nginx 8090, HAProxy 8091 (stats 8404), graph-1/2/3 8083/8085/8086.

Live algorithm switch (both nginx configs are mounted under `/etc/nginx/lab3/`, the active one is a plain copy in `conf.d`, because `docker cp`/`cp` into a `:ro` file mount fails): `docker exec relativa-graph-lb sh -c "cp /etc/nginx/lab3/lc.conf /etc/nginx/conf.d/default.conf && nginx -s reload"` (and `rr.conf` back). Recreating `graph-lb` resets it to Round Robin.

Findings (all measured, see `evidence/lab3/k6/COMPARISON.md` and `defence/lab3.md`):
- **nginx needs `zone` in `upstream`**: without it each of the 8 workers keeps its own round-robin/least_conn state; sequential requests went 10 of 12 to the first server (Lab 2 config). With `zone`: exactly even. Keep `zone` in every future nginx upstream.
- **The ~765 ms latency floor of `GET /api/v1/graph` is the ML RPC timing out**: 3 attempts x 200 ms + back-off, logged as `ml_scoring_degraded` on essentially every request. It is a wait, not CPU, so extra instances do not shorten it. Not fixed (Lab 9 material: why ML answers in more than 200 ms). **Refined in Lab 4:** the floor appears under load because the ML request queue backs up (see the Lab 4 log); an idle system answers in 150-250 ms.
- 1 vs 3 instances in the Lab 2 scenario: no measurable difference (about 30 req/s, noise bigger than the difference). RR vs LC with a slow node: LC cuts the slow node's share 33.3% to 24.6% and the mean 4-6%, but p99 is not reliably better (tail is decided by the slow node).
- Scale-out (saturating 120 VUs, 1 CPU per instance): 23 / 27 / 15-25 req/s for 1 / 2 / 3 instances, failures up to 20%. Proven next bottleneck: PostgreSQL `max_connections=100` vs Npgsql default pool of 100 per instance (1796 `too many clients already`; cap 30 removes them). Observed but not isolated: shared ML + RabbitMQ + PostgreSQL CPU. Balancer and Redis are not limits.
- nginx community = passive health checks only and never calls `/health`; HAProxy (extra) does active checks: on a `docker pause`d node nginx lost 2 requests (12 s each), HAProxy 0.
- Fault tolerance: `docker kill`/`stop` of one instance under load: 0 non-200; nginx retries (`upstream=a, b` in its log); a dead node costs one client 2 s (`proxy_connect_timeout`) every `fail_timeout`.

Evidence: `evidence/lab3/{before,after,scripts,k6}`, `graph-integration-tests.txt` (168/170, same 2 known failures). Scripts: `scripts/common.ps1` (helpers), `algorithm-demo.ps1`, `fault-tolerance-demo.ps1`, `health-check-demo.ps1`, `active-health-demo.ps1`, `asymmetric-run.ps1`, `scale-out-run.ps1`. `k6/compare-summaries.ps1` is the Lab 3 version of the Lab 2 compare script (adds p99 and free column labels, needs runs made with `--summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)"`). The README got a Lab 3 section (appended).

Residual risks: nginx itself is a SPOF (Keepalived/VRRP, DNS RR not built); Gateway still has one Graph destination; Postgres/RabbitMQ/Redis/ML single nodes; Npgsql pool not capped in the normal stack; the 3-instance capped scale-out run is the weakest data point; first asymmetric attempt discarded (Docker hung) and kept in `k6/asymmetric/attempt1-invalid-docker-wedged/`.

#### Lab 3 artificial delay (`ARTIFICIAL_DELAY_MS`): status and how to bring it back

**Current status: PRESENT in Graph `Program.cs` (added in Lab 3; Lab 4 kept it and did not use it; no lab so far has needed it removed).** It is an env-gated test hook: unset or 0 means no effect, only `docker-compose.lab3-slow.yml` turns it on (graph-2, 500 ms). It delays every request of ONE Graph instance with an async `Task.Delay` (no CPU) to simulate a degraded node, for the RR vs LC experiment. It does not delay dependencies (ML, PostgreSQL); a lab that needs that requires a different mechanism.

**Decision rule for agents:** keep it while some lab may need a slow-node experiment. If a lab does not need it and you want a clean diff, remove it, then **replace the status line above with `REMOVED in Lab N`** so the next agent knows. If you remove it, also delete `docker-compose.lab3-slow.yml` and update README/defence mentions of it only on branches where they still say it exists (Lab 3 defence/evidence must stay as they are, they describe the Lab 3 code).

Where it lives (to remove it, delete exactly these):
- `Graph/src/Relativa.Graph/Program.cs`: the block headed `// Lab 3: synthetic latency for the asymmetric-load experiment`, between the instance-ID middleware and `if (redisEnabled)`.
- `docker-compose.lab3-slow.yml`.
- README table row for `ARTIFICIAL_DELAY_MS`.

**How to bring it back** (paste into `Graph/src/Relativa.Graph/Program.cs` right after the instance-ID middleware `app.Use(...)` and before `if (redisEnabled)`; `instanceId` is the variable the instance-ID middleware already uses):

```csharp
// Synthetic latency for asymmetric-load experiments (Lab 3 technique).
// ARTIFICIAL_DELAY_MS > 0 makes THIS instance slow. Unset / 0 = no effect.
var artificialDelayMs = int.TryParse(Environment.GetEnvironmentVariable("ARTIFICIAL_DELAY_MS"), out var delayMs) ? delayMs : 0;
if (artificialDelayMs > 0)
{
    app.Logger.LogWarning("Graph instance {InstanceId} runs with ARTIFICIAL_DELAY_MS={DelayMs}.", instanceId, artificialDelayMs);
    app.Use(async (ctx, next) =>
    {
        await Task.Delay(artificialDelayMs);
        await next(ctx);
    });
}
```

Overlay to recreate (name it for the current lab, e.g. `docker-compose.labN-slow.yml`; keep the Redis/INSTANCE_ID lines so the overlay does not drop them from graph-2):

```yaml
x-redis-conn: &redis-conn "redis:6379,abortConnect=false"
services:
  graph-2:
    environment:
      INSTANCE_ID: graph-2
      Redis__ConnectionString: *redis-conn
      ARTIFICIAL_DELAY_MS: "500"
```

Use: stack it as the last `-f` and recreate only the slow node: `docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml -f docker-compose.labN-slow.yml up -d graph-2`. Remove the file from the command and recreate graph-2 to get full speed. After any change to the hook run the pre-commit check: `python -m lizard -C 10 -L 99999 -a 99999 -l csharp -w Graph/src/Relativa.Graph/Program.cs` must print nothing. Do not leave the slow overlay in the stack during other measurements (it skews every result that passes through that node). The reference implementation is on branch `high-load-systems/lab3`. Reference evidence of how it behaves: `evidence/lab3/k6/asymmetric/` and `COMPARISON.md` section for Experiment B.

### Lab 4: Distributed Caching (done)

Goal: Cache-Aside in Redis for the heaviest read, key design, TTL, invalidation on write, graceful fallback when Redis dies. Branch `high-load-systems/lab4`, evidence `evidence/lab4/`, defence `defence/lab4.md`, README section "Distributed Caching".

What was built (Graph only; no new containers, no new compose file, no new NuGet package):
- Target: `GET /api/v1/graph?organizationId=N`. `IGraphCacheService` (`GetAsync` returns `GraphCacheLookup(Value, Available)`, `SetAsync`, `InvalidateForOrgAsync`), `RedisGraphCacheService` (JSON in `IDistributedCache`; `SCAN`+`DEL` for invalidation through the shared `IConnectionMultiplexer`; every Redis call in try/catch, never throws), `NullGraphCacheService` (registered when `Redis:ConnectionString` is empty, so tests and host runs behave as before Lab 4), `RedisMultiplexerFactory` (one shared multiplexer, `BacklogPolicy.FailFast`, 1 s timeouts, used by `AddStackExchangeRedisCache` via `ConnectionMultiplexerFactory`).
- Key `relativa-graph:graph:v1:{userId}:{orgId}:{riskLevel|all}` (userId is required: permissions differ per user; riskLevel is NOT lower-cased on purpose, `GraphDataService` treats `HIGH` and `high` differently). TTL 60 s +/-10% jitter, config `GraphCache:TtlSeconds`. Response header `X-Cache: HIT | MISS | BYPASS` (BYPASS = Redis unavailable; no write-back attempted).
- Invalidation: `POST /api/v1/workspaces/{id}/entity-graph/create` (the only write endpoint in Graph) looks up the workspace's organization and deletes all of its keys before answering; best effort. Writes that go through Core/Auth do NOT invalidate (TTL only). Natural next step: use Graph's existing RabbitMQ domain-event consumer (`DomainEventConsumerHostedService`, complexity-heavy file: refactor first).
- `Graph/tests/.../GraphCacheTests.cs` (6 tests). Full suite: 174/176; the 2 known `MlClientThrows*` failures remain, plus one environment flake (Testcontainers PostgreSQL timeout) that passed on rerun.

Findings (measured; details in `evidence/lab4/k6/COMPARISON.md`):
- k6, 3 instances behind nginx, original vs cached image, two runs each: median 810 -> 4.5 ms, p95 906 -> 19 ms, 99.1% HIT, ML queue 10 060 -> 0 messages. Run-to-run noise (~10%) is far below the effect, unlike Labs 2 and 3. The throughput gain (+169%) is a closed-loop artefact, not capacity. Best case: one user, one key.
- **The "765 ms floor" of Labs 2 and 3 is not intrinsic to the endpoint.** On an idle system an uncached request takes 150-250 ms. Under load the single ML consumer falls behind (RabbitMQ queue `ml.graph.score_request.v1` grew by 9 000-10 000 messages per 2-minute run, 20 920 after earlier runs; the Graph client gives up after 200 ms but the request stays queued), so the client hits its 3 x 200 ms timeouts. Correlation measured, ML internals not profiled (Lab 9 material). **Always purge the queue before a measurement** (`docker exec relativa-rabbitmq rabbitmqctl purge_queue ml.graph.score_request.v1`; `evidence/lab4/scripts/run-k6.ps1` does it).
- Stampede is visible: about 80 MISS per run (30 VUs miss the same key at start and at each TTL expiry), MISS responses up to 5 s. Not mitigated (only TTL jitter); single-flight / `SET NX` / stale-while-revalidate are the documented next steps.
- Redis in this stack has `maxmemory 0` and `noeviction` (an entry is about 82 KB). Left unchanged because the same Redis holds rate-limit counters and cooldown keys that must not be evicted.
- Fallback proof: `docker stop relativa-redis` -> 12/12 requests 200 with `BYPASS`, `/health` 200, `POST create` 200; after `docker start` the first non-BYPASS answer comes after about 2 s (each instance reconnects on its own).
- `WorkspaceDashboardService` (Lab 2 cooldown through `IDistributedCache`) has no try/catch around Redis: with Redis down that dashboard endpoint fails (fast now, because of `FailFast`). Not touched.

Operational notes learned in Lab 4:
- `POST .../entity-graph/create` needs the **Core** container (RPC over RabbitMQ). It is not part of the usual lab stack: `docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml up -d --no-build core`. Without it the call hangs 30 s and returns 504. Body for a demo client: `{"entityTypeId":1,"properties":[{"propertyId":1,"value":"CacheDemo"}]}`. Demo scripts archive the entities they create (`update entity set is_archived = true where id = N`, DB `relativa`, user `relativa`).
- After rebuilding Graph images, **restart nginx** (`docker restart relativa-graph-lb`): recreated containers can get new IPs and nginx resolves upstreams only at start (k6 would then fail).
- Pre-lab stand with the original image: `evidence/lab4/scripts/orig-image.override.yml` (uses `build: !reset null`, run with `up -d --no-build`; swap back by recreating graph, graph-2, graph-3 without that file).
- k6 start burst: a few requests fail with "connection forcibly closed" in the first seconds (30 new connections at once through Docker Desktop port forwarding), on original and cached code alike (0 to 9 per run, once 51). Not isolated. Report the failures, do not hide them.
- Lizard is silent when everything passes (`-w`); run without `-w` to see the per-method table.

### Lab 5: Load Performance Baseline (done)

Goal: measure the system as it is after Labs 2-4 and write the "SYSTEM PERFORMANCE BASELINE" card: three scenarios, 10/50/100/200 VUs, saturation point, bottleneck, scaling and caching impact. **No application code changed.** Branch `high-load-systems/lab5` (it did not contain Lab 3/4 code; `high-load-systems/lab4` was fast-forward merged into it first). Evidence `evidence/lab5/` (`k6/COMPARISON.md` is the main document, 12 sections), defence `defence/lab5.md`, README section "Load Performance Baseline" (with Mermaid charts), and **tracked** scripts in repo-root `load-tests/lab5/` + `load-tests/README.md` (the lab asks for `/load-tests`; `high-load-systems/` is gitignored).

Design (student's decisions): Scenario A = `GET /api/v1/graph?organizationId=1`, B = real `POST /api/v1/workspaces/1/entity-graph/create` (needs **Core** running; body must contain property 1 and property 3, otherwise 400), C = read + write with 0.3 s think times. Closed model `ramping-vus`, think 0.5 s, 15 s ramp (not measured) + 60 s hold (custom metrics `m_reqs`, `m_failed`, `m_dur`, `m_dur_ok` are recorded only in the hold), warm-up = separate 5 VU / 15 s run, **one k6 run per level**, no thresholds. Throughput = `m_reqs / 60`.

Results (details in COMPARISON.md; all clean runs): A cached: 19.5 / 96.8 / 192 / 364 req/s at 10/50/100/200 VUs (99% linear to 100, tail unstable from 200; at 300 VUs two runs differ 3x: 173 req/s collapse before the Docker restart vs 548 req/s p95 65 ms after it, cause unknown; 500 VUs wedged Docker; the cached read's own limit was never reached). B write: 16.5 then plateau **25-27 req/s** from 50 VUs (staged run: knee at 25 VUs, C also 25), latency 1.4 / 3.6 / 8.4 s, **0% errors** (it queues). C: plateau 30-35 req/s, 65% of reads are MISS (the write invalidates the key). Uncached read: saturates at ~50 VUs (38 req/s), 1% errors at 100, 90% at 200. Scaling 1 vs 3 instances: no difference at 100 VUs, same throughput at 200 VUs (closed-loop bound, 1 instance used 173% CPU, 3 used 63% each), only tail stability differs; at 300 VUs 499 vs 548 req/s, p99 2.7 s vs 0.58 s, 3 instances open 95 of 100 PostgreSQL connections (one run per side). Cache on vs off at 50 VUs: -95% PostgreSQL transactions (49.5k vs 2.4k per run), 2.5x more requests served. Bottleneck of the write path: Graph -> Core RPC over RabbitMQ (RabbitMQ CPU rises 45% -> 242% with the load, others stay at 40-65%; a new connection + channel + exclusive queue per create, probe measured ~28 connections/s = write rate; code in `EntityGraphEndpoints.cs` 111-154 and `ML/RabbitMqMlScoringClient.cs`). **Not proven by a controlled experiment**: removing the churn and re-measuring is the obvious Lab 8-10 task.

Hard lessons (read before measuring anything again):
- **k6 must run in a container on the compose network** (`grafana/k6`, `--network relativa_relativa_net`, `http://relativa-graph-lb`). k6 from the Windows host loses 1-3% of requests to Docker Desktop port forwarding ("wsarecv: forcibly closed", 30-s hangs). Evidence in `k6/attempt1-burst-start/` and `k6/diagnosis-*`.
- **A write run poisons the next runs.** It leaves domain-event backlog (Graph and ML consumers busy for minutes), test entities, 2 `audit_outbox` rows per create and the queue `domain.events.ml.workspace.v1`, which has no consumer (grew to 37 697 messages). **Before every run:** `lab5-lib.ps1` (`Reset-TestData` deletes the entities `Lab5WriteTest` and the outbox rows created since `$OutboxSince`, `Purge-Queues`, `Wait-Settled`). Use `run-k6.ps1`, it does all of it. After any write test, `Reset-TestData` leaves the DB as it was (1394 entities, 22 outbox rows).
- Read runs are disturbed by leftover ML work too: purge `ml.graph.score_request.v1` and wait for idle before every run (A at 200 VUs run 1 was invalid for that reason, kept and labelled).
- **Do not go above 300 VUs** on this machine (500 VUs wedged the Docker engine; recovery in Gotchas).
- Passing lists to `powershell -File script.ps1 -Levels 10, 100` does NOT work (one string). `run-matrix.ps1` and `build-baseline-table.ps1`-style scripts take comma-separated strings, or call the script with `&` inside one PowerShell session.
- `docker stats --no-stream` takes over a minute per call under saturation; the sampler uses the streaming form (`cpu-stream.runN.txt`, summarized by `Summarize-Stats`). `regen-resources.ps1` rebuilds `resources.runN.txt` from a stream.
- Run-to-run noise: under 1-2% below saturation, 14-16% at the knee (A/200, C/100), tails move by an order of magnitude. Plateaus (B 25.6 / 25.7) are reproducible.
- The 765-ms "floor" of uncached reads and the ML queue (Lab 4 finding) are what make uncached A saturate at ~50 VUs and what makes C's reads slow.

Files: `load-tests/lab5/{lib/common.js,scenario-a-read.js,scenario-b-write.js,scenario-c-mixed.js,staged-demo.js}`; `evidence/lab5/scripts/{run-k6.ps1 (one cell), run-matrix.ps1 (main|scaling|caching), run-staged.ps1, staged-table.ps1, lab5-lib.ps1, regen-resources.ps1, nginx-1instance.conf, run-plan*.ps1 (the actual order in which the measurements were made, with the reasons in their headers)}`; `evidence/lab5/k6/{build-baseline-table.ps1, compare-summaries.ps1}`; `evidence/lab5/{environment.txt,logs/}`. Folder map of `evidence/lab5/k6/`: `scenario-{a,b,c}/vus-N/` (main ladders; A also 300), `staged/`, `scaling/` (100 VUs) and `scaling-200/`, `scaling-300/` (1-instance vs 3-instances), `caching/cache-disabled/` (cache-ON side = `scenario-a/vus-50`), `uncached/vus-N/` (original image), `diagnosis-rabbit-churn/`, and the discarded `attempt1-burst-start/`, `attempt2-contaminated-by-write-runs/`, `attempt3-docker-wedged-at-500-vus/`, `diagnosis-*`.

How to reproduce one cell: see `defence/lab5.md` section 13. 1-instance comparison: start `relativa-lab5-lb-1` (`nginx:1.27-alpine`, `scripts/nginx-1instance.conf`, same network); the uncached side uses `evidence/lab4/scripts/orig-image.override.yml` (restore the Lab 4 images afterwards and `docker restart relativa-graph-lb`).

`ARTIFICIAL_DELAY_MS` status: **still PRESENT in Graph `Program.cs`, unused by Lab 5** (no change to the section above).

### Possible next lab hooks
Lab 8 (resilience), 9 (profiling: why ML cannot keep up, RPC connection churn in Graph -> Core and Graph -> ML, stampede protection, Npgsql pool cap), 10 (final optimization) can reuse: `evidence/lab5/scripts/run-k6.ps1` (the strictest protocol so far: clean state, warm-up, container k6, CPU stream, PostgreSQL counters) and the **Lab 5 baseline numbers** as the reference to beat (write plateau 25 req/s, uncached read plateau 38 req/s at 50 VUs, cached read 190 req/s at 100 VUs, 0.3% start-up failures at 200 VUs from the Npgsql pool vs `max_connections=100`), `X-Cache` header, `orig-image.override.yml`.

## 6. Gotchas

- **Non-ASCII text through the shell is destroyed** (PowerShell passes `?` for Cyrillic in commands/heredocs). Write Ukrainian text only with the Write/StrReplace tools, never with `Add-Content`/`Out-File` inside a `Shell` call (this corrupted a README append in Lab 3 and had to be reverted). The console also *displays* UTF-8 as garbage; use the Read tool to check files.
- After a Docker Desktop restart no container starts by itself; re-run the `up -d` of the stack you need (images are kept, no `--build` needed). Under heavy load `docker ps`/`docker stats`/`docker exec` can hang for minutes; kill the stuck `docker` processes and `docker desktop restart`. Do not run measurements while other heavy host programs run (host CPU was at 80% once and invalidated a whole experiment).
- Docker Compose project network is named `relativa_relativa_net` (for `docker run --network`).
- nginx resolves upstream names only at start/reload; a stopped container's name does not resolve, so nginx will not start if an upstream container is not running when it starts. A restarted container normally gets its old IP back, which is why recovery worked in the demos. HAProxy (with `resolvers docker`) re-resolves names.
- `EF Core` request logging at Information level (`Executed DbCommand`) is on in the Graph containers and produces a lot of log I/O under load; unchanged.
- Graph returns HTTP 409 (global exception handler) when the DB is down, not 500.

- Auth `POST /api/v1/support/contact` is anonymous, limited to 5/h per IP (use `X-Forwarded-For` to vary the client IP in demos). `GET/PATCH /api/v1/auth/me` need a JWT; PATCH body: firstName, lastName, phone, dateOfBirth. Graph is read-only for the demo; Auth owns write endpoints.
- The ML client has a 200 ms per-attempt budget, so graph responses can differ in highlight tags between identical calls. When comparing bodies across instances, fingerprint node and edge ids only.
- When proving ML-cooldown behavior, the ML container must be stopped during the probe (otherwise deals are already scored and nothing is enqueued).
- File-based .NET apps (`dotnet run file.cs`) default to AOT-style settings; set `#:property PublishAot=false` and `JsonSerializerIsReflectionEnabledByDefault=true` or JSON (de)serialization throws.
- Graph integration tests use Testcontainers (Docker) and take about 3 minutes.
- `README.md` and several other files at the repo root have uncommitted student edits; append rather than rewrite.

- **Docker Desktop restart recipe (used in Lab 5 after a 500-VU run wedged the engine):** `docker desktop stop`, `docker desktop start`, then nothing is running: `docker start relativa-postgres relativa-redis relativa-rabbitmq relativa-mailhog`, wait ~20 s, `docker start relativa-core relativa-ml relativa-auth relativa-auth-2 relativa-graph relativa-graph-2 relativa-graph-3`, wait, `docker start relativa-graph-lb`, then check `curl -D - -o NUL -H "X-User-Id: 1" "http://localhost:8090/api/v1/graph?organizationId=1"` twice (MISS then HIT). `relativa-sonarqube` restarts by itself (restart policy); stop it (`docker stop relativa-sonarqube`) before heavy runs, it holds 1.2 GB of the 4 GB.
- `load-tests/` at the repo root is tracked by git; `high-load-systems/` is not. Do not move the Lab 5 k6 scripts into the ignored folder.

## 7. Checklist for the next lab

1. Read `description/LabN - *.md`, decide which services matter most, ask the student if unsure.
2. Capture pre-lab k6 stats (and any "before" evidence) on the original code first (twice; see the k6 rules in section 1).
3. Implement; use `docker-compose.labN.yml` overrides, containers only. Run the lizard complexity check on every changed `.cs` file before you consider the code done (rule in section 1), then re-run tests.
4. Capture post-lab k6 stats and "after" evidence; keep raw logs.
5. Write `evidence/labN/k6/COMPARISON.md` (input table + pre/post table with % change and % improvement, see section 1).
6. Write `defence/labN.md` (Ukrainian, with theory Q&A, honest numbers, residual risks, deviations).
7. Update this file (lab log, new gotchas, new ports).
8. Lab 3 additions: use `evidence/lab3/k6/compare-summaries.ps1` (p99, free labels) and run k6 with `--summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)"`; any nginx `upstream` needs `zone`; keep every discarded or invalid run (in a clearly named subfolder) and say so in COMPARISON.md; write Ukrainian only with the Write/StrReplace tools (see Gotchas); the README root file gets a short appended section per lab when the lab description asks for a README report.
9. Lab 4 additions: the Graph ML RabbitMQ queue must be purged before every k6 run (it otherwise holds tens of thousands of stale requests and skews and destabilises results); k6 scripts should count `X-Cache`, and `evidence/lab4/scripts/run-k6.ps1` shows the identical-protocol way to run pre and post; restart nginx after rebuilding Graph images; start Core when a demo needs a write; if you add a cache or a write path, think about invalidation of what bypasses it (Core/Auth writes do not invalidate the Graph cache).
10. Lab 5 additions: run k6 **in a container** on `relativa_relativa_net` (never from the host); use the Lab 5 protocol (`evidence/lab5/scripts/run-k6.ps1`: warm-up, delete test data, purge queues, wait for idle, cold cache, CPU stream, PostgreSQL counters) for every measurement that will be compared with the baseline; every run that is not clean goes to a clearly named "discarded" folder and is listed in COMPARISON.md; take CPU per container during the hold before naming a bottleneck, and say plainly what was not isolated; do not exceed 300 VUs; lists passed to scripts started with `powershell -File` must be comma-separated strings; if a lab changes performance, re-measure the same cells and compare with the Lab 5 numbers (section 5, Lab 5 log).
