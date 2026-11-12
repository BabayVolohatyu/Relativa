# One k6 measurement for Lab 4 with an identical protocol for pre-lab and post-lab.
#
#   powershell -File high-load-systems/evidence/lab4/scripts/run-k6.ps1 -Side pre  -Run 1
#   powershell -File high-load-systems/evidence/lab4/scripts/run-k6.ps1 -Side post -Run 1
#
# Protocol (why each step exists):
#   1. 9 warm-up requests through nginx (3 per instance): JIT / connection pools, the first request after a start takes ~4 s.
#   2. PURGE the RabbitMQ queue ml.graph.score_request.v1. The Graph ML client gives up after 200 ms but the request stays
#      queued, ML (one consumer) can never catch up, and the backlog (20 920 messages after the first runs) makes later runs
#      slower and flakier. Every run therefore starts with an EMPTY queue.
#   3. Delete the graph cache keys (relativa-graph:graph:v1:*), so every post-lab run starts with a COLD cache and the
#      cold fill is part of the measurement. (No-op on the pre-lab stand: the original code never writes them.)
#   4. k6, same script, no thresholds. Output goes to the side's folder: summary.runN.json + k6-output.runN.txt
#   5. Records the ML queue depth after the run (evidence of how much work the system created for ML).
param(
    [Parameter(Mandatory)] [ValidateSet('pre', 'post')] [string] $Side,
    [Parameter(Mandatory)] [int] $Run
)
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$dir = "high-load-systems/evidence/lab4/k6/$Side-lab"
$url = 'http://localhost:8090/api/v1/graph?organizationId=1'

"[1/5] warm-up"
1..9 | ForEach-Object { curl.exe -s -o NUL -w "%{time_total} " -H 'X-User-Id: 1' $url }
""
"[2/5] purge ML request queue"
docker exec relativa-rabbitmq rabbitmqctl purge_queue ml.graph.score_request.v1 2>&1 | Out-Null
"[3/5] delete graph cache keys"
docker exec relativa-redis sh -c "redis-cli --scan --pattern 'relativa-graph:graph:v1:*' | xargs -r redis-cli del" 2>&1 | Out-Null
Start-Sleep -Seconds 5

"[4/5] k6 ($Side-lab, run $Run)"
$out = "$dir/k6-output.run$Run.txt"
k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" --summary-export="$dir/summary.run$Run.json" "$dir/graph-load-test.js" 2>&1 |
    Out-File -Encoding utf8 $out

"[5/5] ML queue depth after the run"
$q = docker exec relativa-rabbitmq rabbitmqctl list_queues name messages 2>&1 | Select-String 'ml.graph.score_request.v1\s'
"ml.graph.score_request.v1 messages after run: $q" | Tee-Object -FilePath "$dir/ml-queue-after.run$Run.txt"
Get-Content $out | Select-Object -Last 30
