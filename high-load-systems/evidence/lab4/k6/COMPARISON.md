# Lab 4 k6: comparison of runs (distributed cache)

Statistics only. There are no thresholds, and a run is never "failed" by k6. The result tables are generated with `compare-summaries.ps1` (this folder, copy of the Lab 3 version) from the `summary.run*.json` files.

What is compared: the **same k6 scenario, the same 3-instance topology (Lab 3)**, with the Graph image **before** (original code, no cache) and **after** (Cache-Aside through Redis) the Lab 4 change. Every side was run **twice**; run 2 is shown as the headline, run 1 right after it, and the run-to-run noise at the end. One additional run is kept but discarded (section 7).

## 1. Test input

| Parameter | Value |
|---|---|
| Tool | Grafana k6 v2.2.0; script `graph-load-test.js` (identical copy in `pre-lab/` and `post-lab/`, it only adds `X-Cache` counters to the Lab 3 script); run with `--summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)"` |
| Executor | `ramping-vus` (closed model: fixed number of virtual users, the arrival rate is NOT fixed) |
| Virtual users | start 30, ramp to 50 over 30 s, hold 50 for 60 s, ramp to 0 over 30 s |
| Total duration | 2 min (+ up to 10 s graceful ramp-down) |
| Target rate | not set (closed loop): request, `sleep(0.5)`, repeat |
| Request | `GET /api/v1/graph?organizationId=1`, header `X-User-Id: 1` (always the same user and organization, so there is exactly **one** cache key; this is the best case for a cache) |
| Response size | about 68 KB (183 nodes, 291 edges) |
| Timeout / check | 60 s / HTTP 200 |
| Thresholds | none |
| Data set | seed data, organization 1 (157-entity workspace), ML service running |
| Protocol of every run (`scripts/run-k6.ps1`) | 9 warm-up requests, then **purge of the RabbitMQ queue `ml.graph.score_request.v1`**, then deletion of the graph cache keys (every post-lab run starts with a cold cache), then k6, then the queue depth is recorded |

## 2. What differed between the runs

| | Pre-lab | Post-lab |
|---|---|---|
| Code | Graph image `relativa-graph-orig`, built from a git worktree of commit `c298418` (the Lab 3 final code, before any Lab 4 change) | Graph images rebuilt from the Lab 4 working tree (Cache-Aside, `X-Cache`, invalidation on create) |
| Topology | 3 Graph instances behind nginx (Round Robin), shared PostgreSQL / Redis / RabbitMQ / ML | the same |
| `BASE_URL` | `http://localhost:8090` | `http://localhost:8090` |
| Extra components | none (Redis is running but the original code does not use it for this endpoint) | Redis stores the graph responses (TTL 60 s, 10% jitter) |
| Traffic split (run 2) | 1191 / 1190 / 1191 (graph-1 / 2 / 3) | 3210 / 3210 / 3210 |
| `X-Cache` (run 2) | no header | HIT 9546, MISS 84, BYPASS 0 |

Pre-lab stand: `docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml -f high-load-systems/evidence/lab4/scripts/orig-image.override.yml up -d --no-build`.

## 3. Results: run 2 (headline)

| Metric | Pre-lab | Post-lab | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3580 | 9630 | +169.0% | +169.0% | better |
| Throughput | 29.78 req/s | 80.14 req/s | +169.1% | +169.1% | better |
| Latency avg | 887.3 ms | 14.6 ms | -98.4% | +98.4% | better |
| Latency min | 767.2 ms | 2.0 ms | -99.7% | +99.7% | better |
| Latency median | 810.0 ms | 4.5 ms | -99.4% | +99.4% | better |
| Latency p90 | 876.7 ms | 13.9 ms | -98.4% | +98.4% | better |
| Latency p95 | 905.8 ms | 19.1 ms | -97.9% | +97.9% | better |
| Latency p99 | 986.7 ms | 39.1 ms | -96.0% | +96.0% | better |
| Latency max | 30013.6 ms | 1108.0 ms | -96.3% | +96.3% | better |
| Server wait (TTFB) avg | 884.9 ms | 13.8 ms | -98.4% | +98.4% | better |
| Server wait (TTFB) p95 | 901.6 ms | 17.2 ms | -98.1% | +98.1% | better |
| Iteration duration avg | 1388.3 ms | 515.4 ms | -62.9% | +62.9% | better |
| Iteration duration p95 | 1406.7 ms | 520.2 ms | -63.0% | +63.0% | better |
| Failed requests | 8 | 0 | -100.0% | +100.0% | better |
| Data received | 0GB 241MB | 0GB 651MB | +169.6% | - | - |

## 4. Results: run 1

| Metric | Pre-lab | Post-lab | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3644 | 8901 | +144.3% | +144.3% | better |
| Throughput | 30.24 req/s | 74.04 req/s | +144.8% | +144.8% | better |
| Latency avg | 864.5 ms | 56.5 ms | -93.5% | +93.5% | better |
| Latency min | 766.9 ms | 1.6 ms | -99.8% | +99.8% | better |
| Latency median | 835.7 ms | 5.0 ms | -99.4% | +99.4% | better |
| Latency p90 | 968.8 ms | 15.2 ms | -98.4% | +98.4% | better |
| Latency p95 | 1029.2 ms | 21.0 ms | -98.0% | +98.0% | better |
| Latency p99 | 1255.2 ms | 487.1 ms | -61.2% | +61.2% | better |
| Latency max | 1730.0 ms | 30013.9 ms | +1634.9% | -1634.9% | worse |
| Server wait (TTFB) avg | 861.4 ms | 55.6 ms | -93.5% | +93.5% | better |
| Server wait (TTFB) p95 | 1024.4 ms | 18.0 ms | -98.2% | +98.2% | better |
| Iteration duration avg | 1366.1 ms | 557.5 ms | -59.2% | +59.2% | better |
| Iteration duration p95 | 1532.6 ms | 522.2 ms | -65.9% | +65.9% | better |
| Failed requests | 0 | 9 | n/a (0 before) | n/a | worse |
| Data received | 0GB 246MB | 0GB 601MB | +144.0% | - | - |

The "worse" rows of run 1 are real and are shown as they are: 9 of 8901 requests failed (a connection reset at the start of the run, k6 then waited its 30 s timeout), which also produces the 30 s max and pulls the average and p99 up. Without them (`expected_response:true` in the k6 output) the average latency of run 1 is 26.2 ms and p99 is 96.9 ms.

## 5. What the cache did (X-Cache counters, ML queue)

| | Pre run 1 | Pre run 2 | Post run 1 | Post run 2 |
|---|---:|---:|---:|---:|
| Responses with `X-Cache: HIT` | 0 | 0 | 8812 | 9546 |
| Responses with `X-Cache: MISS` | 0 | 0 | 80 | 84 |
| Responses with `X-Cache: BYPASS` | 0 | 0 | 0 | 0 |
| Hit ratio (HIT / (HIT + MISS)) | n/a | n/a | 99.1% | 99.1% |
| Latency of HIT responses, avg / p95 | n/a | n/a | 7.6 ms / 19.4 ms | 6.6 ms / 18.0 ms |
| Latency of MISS responses, avg / median / max | n/a | n/a | 2076 ms / 1131 ms / 5181 ms | 928 ms / 938 ms / 1108 ms |
| Messages left in the ML request queue after the run (queue was purged before) | 8980 | 10060 | 0 | 0 |

The roughly 80 MISS per run are: the first burst (30 VUs ask at the same moment while the key does not exist yet, all 30 go to the database: a small **cache stampede**), plus the same burst each time the key expires (60 s TTL +/- 6 s, so about two expiries per run). The slowest MISS responses (up to 5.2 s in run 1) are exactly those bursts.

## 6. Run-to-run noise (same setup, run 1 vs run 2)

Pre-lab (no cache):

| Metric | Pre run 1 | Pre run 2 | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3644 | 3580 | -1.8% | -1.8% | same (within 2%) |
| Throughput | 30.24 req/s | 29.78 req/s | -1.6% | -1.6% | same (within 2%) |
| Latency avg | 864.5 ms | 887.3 ms | +2.6% | -2.6% | worse |
| Latency median | 835.7 ms | 810.0 ms | -3.1% | +3.1% | better |
| Latency p95 | 1029.2 ms | 905.8 ms | -12.0% | +12.0% | better |
| Latency p99 | 1255.2 ms | 986.7 ms | -21.4% | +21.4% | better |
| Latency max | 1730.0 ms | 30013.6 ms | +1634.8% | -1634.8% | worse |
| Failed requests | 0 | 8 | n/a | n/a | n/a |

Post-lab (cache):

| Metric | Post run 1 | Post run 2 | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 8901 | 9630 | +8.2% | +8.2% | better |
| Throughput | 74.04 req/s | 80.14 req/s | +8.2% | +8.2% | better |
| Latency avg | 56.5 ms | 14.6 ms | -74.2% | +74.2% | better |
| Latency median | 5.0 ms | 4.5 ms | -10.7% | +10.7% | better |
| Latency p95 | 21.0 ms | 19.1 ms | -8.7% | +8.7% | better |
| Latency p99 | 487.1 ms | 39.1 ms | -92.0% | +92.0% | better |
| Latency max | 30013.9 ms | 1108.0 ms | -96.3% | +96.3% | better |
| Failed requests | 9 | 0 | -100.0% | +100.0% | better |

The noise (about 10% on the median / p95 of the same side, much more on p99 / max because of 8 to 9 failed requests per side) is **far smaller than the pre/post difference of about 98% on the median and p95**, so unlike Lab 2 and Lab 3 the effect is real and not a measurement artefact. The p99 and max rows are the only ones where noise is of the same size as a pre/post difference; do not quote them as a result.

## 7. Discarded and invalid data

- `pre-lab/attempt1-discarded-51-failures/`: the first pre-lab run, 51 of 2635 requests failed (30 s hangs and connection resets). Right after it the ML request queue held 20 920 messages and `relativa-ml` ran at about 80% CPU while idle. The cause of the failures is **not isolated**; the backlog is only the suspect. The run was discarded and the protocol was changed so that every run starts with a purged ML queue (it is part of `scripts/run-k6.ps1`). The discarded run is kept for transparency; it is not used in any table.
- Failed requests in the kept runs (pre run 2: 8, post run 1: 9) are `wsarecv: An existing connection was forcibly closed by the remote host` at the very start of the run, when 30 new connections open at once through Docker Desktop's port forwarding. They happen on both sides, so they are not caused by the cache. The root cause was not investigated.

## 8. How to read it

1. **The difference is real and large.** The median fell from about 810 ms to about 5 ms and p95 from about 900 ms to about 20 ms; the noise between two runs of the same side is about 10%. The reason is simple and visible in the counters: 99.1% of the responses are `HIT`, a HIT is one Redis `GET` plus JSON (de)serialisation (about 7 ms on average), a MISS is the full database + ML path (about 150 to 800 ms when the system is idle, 1 to 5 s during the stampede bursts).
2. **The ~800 ms floor of Labs 2 and 3 is the uncached path under load, not a property of the endpoint.** When the system is idle one uncached request takes about 150 to 250 ms (see `../after/cache-hit-miss-demo.txt`, the MISS column). Under load the ML service (one consumer) cannot keep up: after every pre-lab run the ML queue held 9 000 to 10 000 unanswered requests, the Graph client times out (3 x 200 ms plus back-off) and answers without scores, which is the 765 ms floor. With the cache the same load creates **no ML work at all** (queue 0 after both post-lab runs). This is a measured correlation, the ML internals were not profiled (that is Lab 9 material).
3. **The throughput gain (+169% / +144%) is an artefact of the closed loop** and must not be read as capacity: a VU sends the next request after the previous answer plus 0.5 s of think time, so shorter answers mean more iterations. The system was not saturated before, and it is not saturated now.
4. **This is a best case.** One user, one organization, one key: every VU hits the same hot key. With many users (one key per user and organization and risk filter) the hit ratio would be lower and the first request of every user would be a MISS. The 60 s TTL is also short enough to produce the stampede bursts of section 5; no single-flight lock was built (see risks in `defence/lab4.md`).
5. **Single-machine caveats.** Everything runs on one Windows host in Docker Desktop with about 4 GB; nginx, k6, the instances, PostgreSQL, ML and Redis compete for the same CPU. Absolute numbers are not transferable, the order of magnitude of the ratio is.
6. **Data received** doubled because the closed loop sent more requests; the response size is the same (about 68 KB).
