# Lab 3 k6: comparison of runs

Statistics only. There are no thresholds, and a run is never "failed" by k6. Tables are generated with `compare-summaries.ps1` (this folder) from the `summary*.json` files; the scale-out and noise tables were computed from the same files.

Four experiments live here, in order of importance for the lab:

| # | Experiment | Folder | What it answers |
|---|---|---|---|
| A | Pre-lab vs post-lab: 1 instance vs 3 instances behind nginx (same scenario as Lab 2) | `pre-lab/`, `post-lab/` | Does the 3-node pool change latency or throughput in the Lab 2 closed-loop scenario? |
| B | Asymmetric load: Round Robin vs Least Connections with one slow node (graph-2, +500 ms) | `asymmetric/` | Which algorithm copes better with a degraded node? |
| C | Scale-out: 1 vs 2 vs 3 instances, saturating load, 1 CPU per instance | `scale-out/` | Does throughput grow with instances, and what limits it? |
| D | Health checks and fault tolerance (not k6, see `../after/`) | `../after/` | Does the pool survive the loss or hang of a node? |

Every k6 side was run **twice** (run 1 and run 2). Run 2 is the headline (file names without a suffix), run 1 is kept as `*.run1.*`. An earlier attempt of experiment B was discarded and is kept in `asymmetric/attempt1-invalid-docker-wedged/` (see section 7).

## 1. Test input

### Experiments A and B (identical scenario, also identical to Lab 2)

| Parameter | Value |
|---|---|
| Tool | Grafana k6 v2.2.0; script `graph-load-test.js` (one copy per folder, only `BASE_URL` and the per-instance counters differ); k6 run with `--summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)"` so that p99 is exported |
| Executor | `ramping-vus` (closed model: fixed number of virtual users, arrival rate is NOT fixed) |
| Virtual users | start 30, ramp to 50 over 30 s, hold 50 for 60 s, ramp to 0 over 30 s |
| Total duration | 2 min (+ up to 10 s graceful ramp-down) |
| Target rate | not set (closed loop): request, `sleep(0.5)`, repeat |
| Request | `GET /api/v1/graph?organizationId=1`, header `X-User-Id: 1` |
| Response size | about 68 KB (183 nodes, 291 edges) |
| Timeout / check | 60 s / HTTP 200 |
| Thresholds | none |
| Data set | seed data, organization 1 (157-entity workspace), ML service running |
| Warm-up | none |

### Experiment C (scale-out, different scenario on purpose)

| Parameter | Value |
|---|---|
| Script | `scale-out/graph-scale-test.js` (via `scripts/scale-out-run.ps1`) |
| Executor | `ramping-vus`: 10 to 120 VUs over 10 s, hold 120 VUs for 50 s, graceful stop 30 s |
| Think time | none: every VU sends the next request immediately (drives the system to saturation) |
| Request, timeout, check | same request; timeout 60 s; HTTP 200 |
| Instances | 1, 2, 3 Graph instances behind nginx (round robin); each Graph container is limited to 1 CPU core (`docker-compose.lab3-cpulimit.yml`) |
| Two variants | default Npgsql pool (max 100 connections per instance) and pool capped at 30 per instance (`docker-compose.lab3-poolcap.yml`) |
| Side sampling | `docker stats` every 5 s during each run (`scale-out/docker-stats-*.txt`, summary in `scale-out/cpu-summary.txt`) |

## 2. What differed between the runs

| | Pre-lab (A) | Post-lab (A) | A/B/C nginx |
|---|---|---|---|
| Code | Lab 2 final (no `/health`, no delay middleware) | Lab 3 final (`/health`, `ARTIFICIAL_DELAY_MS` middleware, unset = no effect) | same as post-lab |
| Topology | 1 Graph instance, hit directly | 3 Graph instances behind nginx | nginx `graph-lb`, 3 upstreams |
| `BASE_URL` | `http://localhost:8083` | `http://localhost:8090` | `http://localhost:8090` |
| Algorithm | none | Round Robin (`graph-lb-lab3-rr.conf`) | RR vs LC in B, RR in C |
| Traffic split (run 2) | 100% graph-1 (3637) | 1230 / 1231 / 1230 (33.3% each) | B below, C: equal split |

Pre-lab was measured on the stack that ran Lab 2's final images (built from the working tree before any Lab 3 change). Post-lab was measured on images rebuilt after the Lab 3 code change. After the post-lab run only the way nginx receives its config changed (both algorithm files are mounted and the active one is copied inside the container, so the algorithm can be switched live); the Round Robin config content is identical.

Experiment B: `docker-compose.lab3-slow.yml` gives graph-2 `ARTIFICIAL_DELAY_MS=500` (every request waits 500 ms before being handled; an async delay, no CPU). Runs were interleaved (RR1, LC1, RR2, LC2) and nginx was switched live between them.

## 3. Experiment A: 1 instance vs 3 instances (Lab 2 scenario)

### Headline: run 2

| Metric | Pre-lab (1 instance) | Post-lab (3 instances) | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3637 | 3691 | +1.5% | +1.5% | same (within 2%) |
| Throughput | 30.22 req/s | 30.56 req/s | +1.1% | +1.1% | same (within 2%) |
| Latency avg | 868.1 ms | 848.5 ms | -2.3% | +2.3% | better |
| Latency min | 767.1 ms | 766.1 ms | -0.1% | +0.1% | same (within 2%) |
| Latency median | 848.6 ms | 836.8 ms | -1.4% | +1.4% | same (within 2%) |
| Latency p90 | 968.2 ms | 908.0 ms | -6.2% | +6.2% | better |
| Latency p95 | 1012.0 ms | 948.3 ms | -6.3% | +6.3% | better |
| Latency p99 | 1095.8 ms | 1048.9 ms | -4.3% | +4.3% | better |
| Latency max | 1243.1 ms | 1314.9 ms | +5.8% | -5.8% | worse |
| Server wait (TTFB) avg | 865.2 ms | 845.8 ms | -2.2% | +2.2% | better |
| Server wait (TTFB) p95 | 1005.1 ms | 943.2 ms | -6.2% | +6.2% | better |
| Iteration duration avg | 1369.7 ms | 1349.6 ms | -1.5% | +1.5% | same (within 2%) |
| Iteration duration p95 | 1513.7 ms | 1450.4 ms | -4.2% | +4.2% | better |
| Failed requests | 0 | 0 | n/a | n/a | same |
| Data received | 0GB 246MB | 0GB 249MB | +1.5% | - | - |

### Earlier: run 1

| Metric | Pre-lab (1 instance) | Post-lab (3 instances) | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3576 | 3607 | +0.9% | +0.9% | same (within 2%) |
| Throughput | 29.79 req/s | 29.99 req/s | +0.7% | +0.7% | same (within 2%) |
| Latency avg | 892.3 ms | 879.6 ms | -1.4% | +1.4% | same (within 2%) |
| Latency min | 766.3 ms | 767.5 ms | +0.2% | -0.2% | same (within 2%) |
| Latency median | 869.2 ms | 853.2 ms | -1.8% | +1.8% | same (within 2%) |
| Latency p90 | 1002.4 ms | 983.4 ms | -1.9% | +1.9% | same (within 2%) |
| Latency p95 | 1059.2 ms | 1043.2 ms | -1.5% | +1.5% | same (within 2%) |
| Latency p99 | 1209.9 ms | 1308.9 ms | +8.2% | -8.2% | worse |
| Latency max | 1681.5 ms | 1643.1 ms | -2.3% | +2.3% | better |
| Server wait (TTFB) avg | 888.9 ms | 876.5 ms | -1.4% | +1.4% | same (within 2%) |
| Server wait (TTFB) p95 | 1055.4 ms | 1037.2 ms | -1.7% | +1.7% | same (within 2%) |
| Iteration duration avg | 1394.1 ms | 1381.1 ms | -0.9% | +0.9% | same (within 2%) |
| Iteration duration p95 | 1561.0 ms | 1544.9 ms | -1.0% | +1.0% | same (within 2%) |
| Failed requests | 0 | 0 | n/a | n/a | same |
| Data received | 0GB 242MB | 0GB 244MB | +0.8% | - | - |

Traffic split, run 1: 1203 / 1202 / 1202.

### Run-to-run noise (same setup, run 1 to run 2)

| Metric | Pre-lab run 1 | Pre-lab run 2 | Change % | Post-lab run 1 | Post-lab run 2 | Change % |
|---|---:|---:|---:|---:|---:|---:|
| Throughput | 29.79 req/s | 30.22 req/s | +1.4% | 29.99 req/s | 30.56 req/s | +1.9% |
| Latency avg | 892.3 ms | 868.1 ms | -2.7% | 879.6 ms | 848.5 ms | -3.5% |
| Latency median | 869.2 ms | 848.6 ms | -2.4% | 853.2 ms | 836.8 ms | -1.9% |
| Latency p90 | 1002.4 ms | 968.2 ms | -3.4% | 983.4 ms | 908.0 ms | -7.7% |
| Latency p95 | 1059.2 ms | 1012.0 ms | -4.5% | 1043.2 ms | 948.3 ms | -9.1% |
| Latency p99 | 1209.9 ms | 1095.8 ms | -9.4% | 1308.9 ms | 1048.9 ms | -19.9% |
| Iteration duration p95 | 1561.0 ms | 1513.7 ms | -3.0% | 1544.9 ms | 1450.4 ms | -6.1% |

**Reading A:** throughput is the same within noise (about 30 req/s in all four runs, difference between sides 0.7 to 1.1%, noise between runs 1.4 to 1.9%). The tail percentiles (p95, p99) look a few percent better after in run 2 and worse in run 1, and the run-to-run noise on p99 (up to 20%) is larger than the pre/post difference, so **there is no measurable gain** and none should be claimed. Reason: the scenario is latency-bound. Every request has a floor of about 765 ms (minimum latency 766 to 768 ms in all four runs) and 50 VUs produce about 30 req/s regardless of how many instances exist, so one instance was never saturated. The floor was identified in this lab: the Graph service asks the ML service for scores over RabbitMQ RPC with a 200 ms per-attempt budget and 3 attempts; the ML replies do not arrive in time, so every request spends 3 x 200 ms plus back-off (50 and 100 ms), about 750 ms, waiting for timeouts (`ml_scoring_degraded attempts=3 reason=ML scoring attempt exceeded 200ms` was logged 9099 times by graph-1 over its lifetime, which included the two pre-lab runs with 7213 k6 requests plus some manual probes: about one degraded warning per request or more). It is a wait, not CPU, which is why more instances do not shorten it.

## 4. Experiment B: Round Robin vs Least Connections with one slow node

graph-2 handles every request 500 ms slower; graph-1 and graph-3 are normal. Same scenario as A (50 VUs, think time 0.5 s).

### Headline: run 2

| Metric | Round Robin | Least Connections | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3402 | 3492 | +2.6% | +2.6% | better |
| Throughput | 28.09 req/s | 28.99 req/s | +3.2% | +3.2% | better |
| Latency avg | 966.6 ms | 927.0 ms | -4.1% | +4.1% | better |
| Latency min | 767.2 ms | 764.5 ms | -0.3% | +0.3% | same (within 2%) |
| Latency median | 806.1 ms | 803.9 ms | -0.3% | +0.3% | same (within 2%) |
| Latency p90 | 1305.2 ms | 1299.3 ms | -0.5% | +0.5% | same (within 2%) |
| Latency p95 | 1315.7 ms | 1314.7 ms | -0.1% | +0.1% | same (within 2%) |
| Latency p99 | 1347.8 ms | 1377.3 ms | +2.2% | -2.2% | worse |
| Latency max | 1628.5 ms | 1600.2 ms | -1.7% | +1.7% | same (within 2%) |
| Server wait (TTFB) avg | 965.0 ms | 925.3 ms | -4.1% | +4.1% | better |
| Server wait (TTFB) p95 | 1313.8 ms | 1312.5 ms | -0.1% | +0.1% | same (within 2%) |
| Iteration duration avg | 1467.7 ms | 1428.0 ms | -2.7% | +2.7% | better |
| Iteration duration p95 | 1816.5 ms | 1815.5 ms | -0.1% | +0.1% | same (within 2%) |
| Failed requests | 0 | 0 | n/a | n/a | same |
| Data received | 0GB 230MB | 0GB 236MB | +2.6% | - | - |

### Earlier: run 1

| Metric | Round Robin | Least Connections | Change % | Improvement % | Verdict |
|---|---:|---:|---:|---:|---|
| Total requests | 3281 | 3419 | +4.2% | +4.2% | better |
| Throughput | 27.00 req/s | 28.26 req/s | +4.7% | +4.7% | better |
| Latency avg | 1020.0 ms | 956.0 ms | -6.3% | +6.3% | better |
| Latency min | 726.0 ms | 765.6 ms | +5.4% | -5.4% | worse |
| Latency median | 874.5 ms | 832.8 ms | -4.8% | +4.8% | better |
| Latency p90 | 1368.7 ms | 1323.2 ms | -3.3% | +3.3% | better |
| Latency p95 | 1417.6 ms | 1351.3 ms | -4.7% | +4.7% | better |
| Latency p99 | 1547.3 ms | 1472.3 ms | -4.8% | +4.8% | better |
| Latency max | 1861.0 ms | 1873.3 ms | +0.7% | -0.7% | same (within 2%) |
| Server wait (TTFB) avg | 1017.1 ms | 953.6 ms | -6.2% | +6.2% | better |
| Server wait (TTFB) p95 | 1413.4 ms | 1348.2 ms | -4.6% | +4.6% | better |
| Iteration duration avg | 1521.4 ms | 1457.2 ms | -4.2% | +4.2% | better |
| Iteration duration p95 | 1919.7 ms | 1852.2 ms | -3.5% | +3.5% | better |
| Failed requests | 0 | 0 | n/a | n/a | same |
| Data received | 0GB 221MB | 0GB 231MB | +4.2% | - | - |

### Traffic share per instance (the mechanism)

| Run | Algorithm | graph-1 | graph-2 (slow) | graph-3 | Slow node share |
|---|---|---:|---:|---:|---:|
| Run 2 | Round Robin | 1134 | 1134 | 1134 | 33.3% |
| Run 2 | Least Connections | 1316 | 860 | 1316 | 24.6% |
| Run 1 | Round Robin | 1094 | 1094 | 1093 | 33.3% |
| Run 1 | Least Connections | 1291 | 841 | 1287 | 24.6% |

Per-instance latency (run 2, both algorithms): graph-1 and graph-3 average about 800 ms, graph-2 about 1300 ms (p99 1.41 s under RR, 1.47 s under LC).

### Run-to-run noise

| Metric | RR run 1 | RR run 2 | Change % | LC run 1 | LC run 2 | Change % |
|---|---:|---:|---:|---:|---:|---:|
| Throughput | 27.00 req/s | 28.09 req/s | +4.0% | 28.26 req/s | 28.99 req/s | +2.6% |
| Latency avg | 1020.0 ms | 966.6 ms | -5.2% | 956.0 ms | 927.0 ms | -3.0% |
| Latency p95 | 1417.6 ms | 1315.7 ms | -7.2% | 1351.3 ms | 1314.7 ms | -2.7% |
| Latency p99 | 1547.3 ms | 1347.8 ms | -12.9% | 1472.3 ms | 1377.3 ms | -6.5% |

**Reading B:** Least Connections does what it should mechanically and reproducibly: the slow node's share fell from 33.3% to 24.6% in both runs (about 25% fewer requests to it), and the average latency was 4 to 6% lower and throughput 3 to 5% higher in both runs. The system **p99 did not improve reliably**: -4.8% in run 1, +2.2% in run 2, inside the run-to-run noise (up to 13%). This is the expected result, not a failure: p95 and p99 are decided by the slowest node as long as it still receives more than about 1 to 5% of the traffic. With a 500 ms handicap the slow node still got about a quarter of the requests, and each of those takes about 1.3 s, so the tail stays near 1.3 to 1.4 s whichever algorithm is used. Least Connections reduces the average cost of the slow node; it does not remove its tail. Removing the tail needs ejecting the node (health check, outlier detection) or a very large handicap with many concurrent requests. Only one handicap (500 ms), one concurrency (50 VUs, closed loop) and two runs per side were measured.

## 5. Experiment C: scale-out, 1 vs 2 vs 3 instances

Saturating load (120 VUs, no think time), each Graph instance limited to 1 CPU core. One run per cell (the failure modes below are far larger than normal noise, but this is not a repeated measurement).

| Variant | Instances | Requests | Throughput | Latency avg | Latency median | Latency p95 | Latency p99 | Failed |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 CPU/instance, default Npgsql pool | 1 | 1621 | 23.15 req/s | 4258.4 ms | 3651.0 ms | 6200.8 ms | 30008.7 ms | 2.5% (41 of 1621) |
| 1 CPU/instance, default Npgsql pool | 2 | 1861 | 27.07 req/s | 3773.4 ms | 1190.8 ms | 16232.7 ms | 30013.2 ms | 19.6% (364 of 1861) |
| 1 CPU/instance, default Npgsql pool | 3 | 1731 | 24.72 req/s | 4103.5 ms | 1195.1 ms | 30006.0 ms | 30014.6 ms | 17.6% (304 of 1731) |
| 1 CPU/instance, pool capped at 30 | 1 | 1527 | 21.83 req/s | 4591.3 ms | 3228.8 ms | 30002.5 ms | 30014.0 ms | 5.4% (82 of 1527) |
| 1 CPU/instance, pool capped at 30 | 2 | 1936 | 27.65 req/s | 3646.5 ms | 1411.1 ms | 30006.3 ms | 30015.1 ms | 6.6% (127 of 1936) |
| 1 CPU/instance, pool capped at 30 | 3 | 1043 | 14.91 req/s | 7007.9 ms | 1620.1 ms | 30012.6 ms | 30016.0 ms | 17.2% (179 of 1043) |

Mean container CPU over the samples (`scale-out/cpu-summary.txt`, percent of one core; the 3-instance capped run has no samples because `docker stats` stalled under load):

| Run | graph-1 | graph-2 | graph-3 | ml | postgres | rabbitmq |
|---|---:|---:|---:|---:|---:|---:|
| 1 instance | 61 | - | - | 76 | 57 | 38 |
| 2 instances | 38 | 63 | - | 70 | 105 | 101 |
| 3 instances | 20 | 25 | 37 | 64 | 77 | 88 |
| 1 instance, pool capped | 68 | - | - | 76 | 45 | 65 |
| 2 instances, pool capped | 49 | 66 | - | 74 | 56 | 124 |

Hard evidence for the connection limit: PostgreSQL logged `sorry, too many clients already` **1796** times during the uncapped runs (`max_connections` = 100, each Graph instance may open up to 100 pooled connections); the count stayed at 1796 during the capped runs (`scale-out/pg-too-many-clients-*.txt`), and the Graph logs show no connection errors in the capped runs.

**Reading C (honest):**

- **Throughput did not scale with instances.** About 22 to 23 req/s with 1 instance, about 27 req/s with 2, and 15 to 25 req/s with 3, while failures rose to 6 to 20% (30 s timeouts and errors). Adding compute nodes did not add capacity.
- **A single 1-core Graph instance is CPU-bound at about 22 req/s** (graph-1 about 97 to 104% of its core in the sampled seconds). Beyond that point the shared components, not Graph, are the limit.
- **Next bottleneck 1, proven: PostgreSQL connection limit.** With the default pool the instances together ask for more connections than the server allows; the pool cap removes the `too many clients` errors (1796 before, 0 new after) and cut failures at 2 instances from 19.6% to 6.6%.
- **Next bottleneck 2, observed but not isolated: shared ML RPC path and RabbitMQ.** ml stays at 64 to 76% of a core, RabbitMQ at 100 to 180% and PostgreSQL at 100 to 160% at 2 and 3 instances, and every Graph request makes 3 ML RPC attempts through RabbitMQ (retries multiply the load: 120 VUs x 3 attempts). After the connection cap, throughput still did not scale and a 30 s tail remained (equal to the EF Core `CommandTimeout=30`, a coincidence not verified). Which of ML, RabbitMQ or PostgreSQL CPU is the binding one was **not profiled** (Lab 9).
- The nginx balancer is not the limit (about 2 to 5% CPU), Redis is idle (about 1%), and the network is not saturated.
- Caveats: all containers share one 8-core laptop together with k6, so the "separate nodes" are simulated by the 1-core limit; the 3-instance capped run is the weakest data point (no `docker stats`, 1043 requests, likely affected by machine-wide contention); one run per cell.

## 6. Experiment D: health checks and fault tolerance

Not k6; raw logs in `../after/`:

| Test | Result | File |
|---|---|---|
| Kill (`docker kill`) graph-2 under 4 parallel client loops | 214 requests, **0 non-200**, 0 served by graph-2 while dead, 3 requests retried by nginx on another upstream, graph-2 served again 3.6 s after `docker start` | `after/fault-tolerance-kill.txt` |
| Stop (`docker stop`) graph-3 | 215 requests, **0 non-200**, 1 request finished by graph-3 while it drained, 3 retries, back after 3.9 s | `after/fault-tolerance-stop.txt` |
| `/health` | 200 `Healthy` on all three; 503 `Unhealthy` on all three when PostgreSQL is stopped; back to 200 without restarting Graph | `after/health-check.txt` |
| Hung node (`docker pause` graph-3): nginx passive vs HAProxy active | nginx: 2 of 4 requests in the window failed after 12 s; HAProxy: 0 of 21 failed, node marked DOWN by the `/health` check in under 10 s and UP again after unfreeze | `after/active-vs-passive-health-check.txt` |

## 7. Data quality notes

- First attempt of experiment B (`asymmetric/attempt1-invalid-docker-wedged/`): Docker Desktop became unresponsive during run 2 (even `docker ps` hung), the machine was at about 80% CPU, and throughput collapsed to 4.7 req/s with 27% failures in the RR run. That attempt is not a measurement of the algorithms, was discarded, and the experiment was repeated from scratch after a Docker restart. Both attempts are kept.
- The k6 scenario of A and B is closed-loop and latency-bound: it measures per-request latency, not capacity. Capacity is only visible in experiment C.
- Single machine: all containers and k6 share one laptop, so absolute numbers are not production numbers; only the relative behaviour is meaningful.
