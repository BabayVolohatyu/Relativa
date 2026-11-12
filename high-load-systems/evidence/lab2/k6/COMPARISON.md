# Lab 2 k6: pre-lab vs post-lab comparison

Statistics only. There are no thresholds, and the run is never "failed" by k6. Tables are generated with `compare-summaries.ps1` from the `summary.json` files.

Two runs exist for each side (run 1 and run 2), so the run-to-run noise of this machine is visible next to the pre/post difference. The headline comparison is **run 2** (latest code, same session for both sides). Run 1 is kept because it was recorded earlier and is part of the history.

| Run | When | Pre-lab (original code, 1 instance) | Post-lab (refactored code, 2 instances) |
|---|---|---|---|
| Run 1 | First implementation session | `pre-lab/summary.run1.json`, `pre-lab/k6-output.run1.txt` | `post-lab/summary.run1.json`, `post-lab/k6-output.run1.txt` |
| Run 2 (headline) | After the cyclomatic-complexity refactor of `WorkspaceDashboardService`, images rebuilt | `pre-lab/summary.json`, `pre-lab/k6-output.txt` | `post-lab/summary.json`, `post-lab/k6-output.txt` |

How run 2 was produced: the pre-lab Graph image was built from a git worktree of the original commit (`HEAD`, before any Lab 2 change) and run in the base stack (`postgres rabbitmq migration graph ml`); the post-lab stack was rebuilt from the working tree with `docker compose -f docker-compose.yaml -f docker-compose.lab2.yml up -d --build`.

## 1. Test input (identical for all runs)

| Parameter | Value |
|---|---|
| Tool | Grafana k6 v2.2.0, scenario file `graph-load-test.js` (same script in `pre-lab/` and `post-lab/`, only `BASE_URL` differs) |
| Executor | `ramping-vus` (closed model: a fixed number of virtual users, arrival rate is NOT fixed) |
| Virtual users (VU) | start 30, ramp to 50 over 30 s, hold 50 for 60 s, ramp to 0 over 30 s |
| Total duration | 2 min (+ up to 10 s graceful ramp-down) |
| Target rate | not set (closed loop); each VU does request, then `sleep(0.5)`, then repeats |
| Think time | 0.5 s between requests |
| Request | `GET /api/v1/graph?organizationId=1` with header `X-User-Id: 1` |
| Response size | about 68 KB per response (183 nodes, 291 edges) |
| Request timeout | 60 s |
| Success check | HTTP 200 |
| Thresholds | none |
| Data set | seed data: organization 1, 157-entity workspace, ML scoring service running |
| Warm-up | none (the first requests after a cold start are included, which is why "Latency max" can be large) |

### What differed between the sides

| | Pre-lab | Post-lab |
|---|---|---|
| Code | original commit (in-memory cache, local SignalR groups) | refactored (Redis cache + backplane, `X-Instance-ID`, lower-complexity `WorkspaceDashboardService`) |
| Topology | 1 Graph instance, hit directly | 2 Graph instances behind nginx round-robin |
| `BASE_URL` | `http://localhost:8083` | `http://localhost:8090` |
| Extra components | none | nginx `graph-lb`, Redis |
| Traffic split (run 2) | 100% on the single instance | graph-1 1884 requests, graph-2 1886 requests (50% / 50%) |

## 2. Headline result: run 2, pre-lab vs post-lab

Change % = (post − pre) / pre × 100. Improvement % flips the sign for "lower is better" metrics (latency, errors), so a positive value always means better and a negative value means worse.

| Metric | Pre-lab | Post-lab | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3664 | 3770 | +2.9% | +2.9% | better |
| Throughput | 30.44 req/s | 31.40 req/s | +3.2% | +3.2% | better |
| Latency avg | 859.4 ms | 820.6 ms | -4.5% | +4.5% | better |
| Latency min | 764.1 ms | 766.1 ms | +0.3% | -0.3% | same (within 2%) |
| Latency median | 806.1 ms | 805.7 ms | 0.0% | 0.0% | same (within 2%) |
| Latency p90 | 890.0 ms | 873.0 ms | -1.9% | +1.9% | same (within 2%) |
| Latency p95 | 941.2 ms | 909.5 ms | -3.4% | +3.4% | better |
| Latency max | 4842.1 ms | 1264.9 ms | -73.9% | +73.9% | better |
| Server wait (TTFB) avg | 856.9 ms | 818.6 ms | -4.5% | +4.5% | better |
| Server wait (TTFB) p95 | 934.8 ms | 906.2 ms | -3.1% | +3.1% | better |
| Iteration duration avg | 1360.6 ms | 1321.8 ms | -2.8% | +2.8% | better |
| Iteration duration p95 | 1443.3 ms | 1412.6 ms | -2.1% | +2.1% | better |
| Failed requests | 0 | 0 | n/a | n/a | same |
| Data received | 0GB 247MB | 0GB 255MB | +2.9% | - | - |

Sizes are written as GB + MB in decimal units (1 GB = 1000 MB), e.g. `2GB 567MB`. Exact byte counts are in the `summary.json` files. Checks: 100% passed in both runs (3664 and 3770 requests); HTTP failure rate 0.00% in both.

"Latency max" is dominated by a single cold-start request (the pre-lab stack had just been started, the post-lab stack had been exercised by the evidence scripts first). It is not a meaningful improvement.

## 3. Earlier result: run 1, pre-lab vs post-lab

| Metric | Pre-lab | Post-lab | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3587 | 3424 | -4.5% | -4.5% | worse |
| Throughput | 29.85 req/s | 28.35 req/s | -5.0% | -5.0% | worse |
| Latency avg | 886.9 ms | 954.4 ms | +7.6% | -7.6% | worse |
| Latency min | 768.6 ms | 772.2 ms | +0.5% | -0.5% | same (within 2%) |
| Latency median | 840.0 ms | 895.2 ms | +6.6% | -6.6% | worse |
| Latency p90 | 981.9 ms | 1112.5 ms | +13.3% | -13.3% | worse |
| Latency p95 | 1058.4 ms | 1274.8 ms | +20.4% | -20.4% | worse |
| Latency max | 3600.4 ms | 3460.2 ms | -3.9% | +3.9% | better |
| Server wait (TTFB) avg | 883.1 ms | 949.6 ms | +7.5% | -7.5% | worse |
| Server wait (TTFB) p95 | 1044.8 ms | 1267.4 ms | +21.3% | -21.3% | worse |
| Iteration duration avg | 1388.3 ms | 1456.6 ms | +4.9% | -4.9% | worse |
| Iteration duration p95 | 1559.9 ms | 1783.9 ms | +14.4% | -14.4% | worse |
| Failed requests | 0 | 0 | n/a | n/a | same |
| Data received | 0GB 242MB | 0GB 231MB | -4.5% | - | - |

Run 1 pointed the other way (post-lab slightly worse). Run 1 of the post-lab side was recorded right after a Docker Desktop restart, which likely inflated its latency.

## 4. Run-to-run noise (same setup, run 1 → run 2)

This is the same configuration measured twice. It shows how much the numbers move without any change in the system.

| Metric | Pre-lab run 1 | Pre-lab run 2 | Change % | Post-lab run 1 | Post-lab run 2 | Change % |
|---|---:|---:|---:|---:|---:|---:|
| Throughput | 29.85 req/s | 30.44 req/s | +2.0% | 28.35 req/s | 31.40 req/s | +10.8% |
| Latency avg | 886.9 ms | 859.4 ms | -3.1% | 954.4 ms | 820.6 ms | -14.0% |
| Latency median | 840.0 ms | 806.1 ms | -4.0% | 895.2 ms | 805.7 ms | -10.0% |
| Latency p90 | 981.9 ms | 890.0 ms | -9.4% | 1112.5 ms | 873.0 ms | -21.5% |
| Latency p95 | 1058.4 ms | 941.2 ms | -11.1% | 1274.8 ms | 909.5 ms | -28.7% |
| Iteration duration p95 | 1559.9 ms | 1443.3 ms | -7.5% | 1783.9 ms | 1412.6 ms | -20.8% |

## 5. How to read it

- **There is no measurable speed or throughput difference between 1 and 2 instances in this test.** Run 1 showed post-lab about 5% slower, run 2 showed it about 3% faster. The run-to-run noise (up to about 11% on the pre-lab side and about 29% on the post-lab p95) is larger than either difference, so neither direction is a result. Do not claim an improvement.
- **Why nothing changes:** the test is closed-loop with 50 VUs. Every request already takes about 765 ms in the best case (minimum latency is the same in all four runs: 764 to 772 ms), so a single instance was not saturated and a second instance has no queue to drain. All containers share one laptop, so a second instance adds no hardware. Redis is not on the `GET /api/v1/graph` read path.
- **Where the 765 ms goes** (ML RPC, database, graph assembly) was not profiled in this lab.
- **What the lab actually delivers is not speed** but the ability to run several instances and lose one safely: 50% / 50% traffic split, 0 failed requests, and the instance-loss scenario with 0 failures out of 77 requests (`../after/restart-scenario.txt`).
- **What would show a gain** (not run): an open-model test (`constant-arrival-rate`) set above one instance's capacity, a container CPU limit so one instance is the bottleneck, or separate hosts.
