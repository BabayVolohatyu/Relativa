# One k6 measurement for Lab 5. Same protocol for every scenario, VU level and topology.
#
#   powershell -File high-load-systems/evidence/lab5/scripts/run-k6.ps1 -Scenario A -Vus 50 -OutDir scenario-a/vus-50 -Run 1
#
# Parameters
#   -Scenario A|B|C  which script of load-tests/lab5 to run (read / write / mixed)
#   -Vus N           virtual users of the measured run
#   -OutDir          folder under high-load-systems/evidence/lab5/k6/ for summary.runN.json, k6-output.runN.txt, ...
#   -Run N           run number (files are never overwritten: summary.run1.json, summary.run2.json ...)
#   -BaseUrl         entry point AS SEEN FROM THE k6 CONTAINER (default http://relativa-graph-lb = nginx, 3 Graph
#                    instances; http://relativa-lab5-lb-1 = the single-upstream nginx of the scaling experiment)
#   -Duration        length of the measured hold (default 60s); the ramp-up (15 s) comes before it and is not measured
#
# WHERE k6 RUNS: in a container (grafana/k6, v2.3.0) attached to the compose network relativa_relativa_net, NOT on the
# Windows host. Reason (measured, evidence/lab5/k6/diagnosis-host-port-forward-resets): from the host every run with
# 100+ VUs lost 1-3% of its requests to "wsarecv: connection forcibly closed" / 30 s hangs in Docker Desktop's port
# forwarding (251 of 14 709 at 200 VUs), while the same load from inside the network had 0 failures. The container
# also separates the load generator's network path from the SUT. (It still shares the same CPUs, see COMPARISON.md.)
#
# Protocol (why each step exists):
#   1. Warm-up: a short k6 run (5 VUs, 15 s) of the SAME script. Initialises connection pools, JIT, DNS, Redis multiplexer.
#      Its numbers are discarded.
#   2. CLEAN STATE (lab5-lib.ps1): DELETE the test entities and the audit_outbox rows of earlier runs + VACUUM ANALYZE,
#      PURGE the RabbitMQ queues the tests fill (ml.graph.score_request.v1 and the event queues), then WAIT until the queues
#      are empty and the services are idle (CPU below 8%). Reason: write runs leave backlog and data that slow down
#      every later run (see lab5-lib.ps1); the first attempts without this step were contaminated.
#   3. Delete the graph cache keys (relativa-graph:graph:v1:*), so every run starts with a COLD cache and the cold
#      fill is part of the measurement.
#   4. (queues were purged in step 2)
#   5. Background sampler: docker stats + PostgreSQL connection count, 4 samples inside the hold (resources.runN.txt).
#   6. k6, no thresholds. summary.runN.json + k6-output.runN.txt.
#   7. After the run: RabbitMQ queue depths, number of Redis cache keys, number of entities created (B and C), then
#      delete them (Reset-TestData).
param(
    [Parameter(Mandatory)] [ValidateSet('A', 'B', 'C')] [string] $Scenario,
    [Parameter(Mandatory)] [int] $Vus,
    [Parameter(Mandatory)] [string] $OutDir,
    [int] $Run = 1,
    [string] $BaseUrl = 'http://relativa-graph-lb',
    [string] $Duration = '60s'
)
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$dir = "high-load-systems/evidence/lab5/k6/$OutDir"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$script = switch ($Scenario) { 'A' { 'scenario-a-read.js' } 'B' { 'scenario-b-write.js' } 'C' { 'scenario-c-mixed.js' } }
$writes = $Scenario -ne 'A'
$stats = '--summary-trend-stats=avg,min,med,max,p(90),p(95),p(99)'

. "$PSScriptRoot\lab5-lib.ps1"
# k6 in a container on the compose network. Extra arguments are k6 arguments.
function Invoke-K6($vus, $duration, $summaryName) {
    $outMount = Join-Path $repo $dir
    docker run --rm --name lab5-k6 --network relativa_relativa_net `
        -v "$($repo)\load-tests:/lt:ro" -v "${outMount}:/out" grafana/k6:latest `
        run -q $stats -e "BASE_URL=$BaseUrl" -e "VUS=$vus" -e "DURATION=$duration" "--summary-export=/out/$summaryName" "/lt/lab5/$script" 2>&1
}

"[1/7] warm-up (k6 container, 5 VUs, 15 s, discarded)"
Invoke-K6 5 '15s' 'warmup-discarded.json' | Out-Null
Remove-Item (Join-Path $repo "$dir/warmup-discarded.json") -ErrorAction SilentlyContinue

"[2/7] reset test data (delete test entities + audit_outbox rows, vacuum), purge queues, wait until the system is idle"
Reset-TestData
Purge-Queues
$settle = Wait-Settled
"      settled after $settle s"
"[3/7] delete graph cache keys"
docker exec relativa-redis sh -c "redis-cli --scan --pattern 'relativa-graph:graph:v1:*' | xargs -r redis-cli del" 2>&1 | Out-Null
Start-Sleep -Seconds 5

"[4/7] (nothing: queues were purged in step 2)"
"[5/7] start resource sampler"
$resFile = Join-Path $repo "$dir/pgconn.run$Run.txt"
Remove-Item $resFile -ErrorAction SilentlyContinue
$streamFile = Join-Path $repo "$dir/cpu-stream.run$Run.txt"
Remove-Item $streamFile -ErrorAction SilentlyContinue
# docker stats STREAMING (not --no-stream: that call took more than a minute under saturation and produced samples taken after the run)
$sampler = Start-Job -ScriptBlock {
    param($file)
    docker stats --format "{{.Name}} {{.CPUPerc}} {{.MemUsage}}" 2>&1 | ForEach-Object { "$(Get-Date -Format HH:mm:ss) $_" } | Out-File -Append -Encoding utf8 $file
} -ArgumentList $streamFile
$pgSampler = Start-Job -ScriptBlock {
    param($file)
    Start-Sleep -Seconds 28
    for ($i = 0; $i -lt 5; $i++) {
        $pg = docker exec relativa-postgres psql -U relativa relativa -tAc "select 'pg_connections total=' || count(*) || ' active=' || count(*) filter (where state = 'active') from pg_stat_activity where datname = 'relativa'" 2>&1
        "$(Get-Date -Format HH:mm:ss) $pg" | Out-File -Append -Encoding utf8 $file
        Start-Sleep -Seconds 6
    }
} -ArgumentList $resFile

"[6/7] k6 container ($Scenario, $Vus VUs, 15 s ramp + $Duration hold, run $Run, $BaseUrl)"
$out = "$dir/k6-output.run$Run.txt"
$db0 = Get-DbCounters
$t0 = Get-Date
Invoke-K6 $Vus $Duration "summary.run$Run.json" | Out-File -Encoding utf8 $out
"k6 wall time: $([int]((Get-Date) - $t0).TotalSeconds) s"
$db1 = Get-DbCounters
@("PostgreSQL counters (pg_stat_database) between k6 start and k6 end, whole run incl. ramp-up:", "  transactions: $($db1[0] - $db0[0])", "  rows returned by queries (tup_returned): $($db1[1] - $db0[1])", "  rows fetched (tup_fetched): $($db1[2] - $db0[2])", "  blocks read+hit: $($db1[3] - $db0[3])") | Out-File -Encoding utf8 "$dir/db-load.run$Run.txt"
$tEnd = Get-Date
$null = Start-Sleep -Seconds 1
Stop-Job $sampler -ErrorAction SilentlyContinue
Remove-Job $sampler -Force -ErrorAction SilentlyContinue
Get-CimInstance Win32_Process -Filter "Name='docker.exe'" | Where-Object { $_.CommandLine -match 'stats --format' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
Stop-Job $pgSampler -ErrorAction SilentlyContinue; Remove-Job $pgSampler -Force -ErrorAction SilentlyContinue
Summarize-Stats $streamFile $t0.AddSeconds(25) $tEnd.AddSeconds(-5) | Out-File -Encoding utf8 "$dir/resources.run$Run.txt"
if (Test-Path $resFile) { "PostgreSQL connections to the lab database (sampled in the hold):" | Add-Content -Encoding utf8 "$dir/resources.run$Run.txt"; Get-Content $resFile | Add-Content -Encoding utf8 "$dir/resources.run$Run.txt"; Remove-Item $resFile }

"[7/7] after the run"
$after = @()
$after += "queues after run (name messages):"
$after += (docker exec relativa-rabbitmq rabbitmqctl list_queues name messages 2>&1 | Select-String 'ml.graph.score_request.v1\s|core.entity_graph.create\s' | ForEach-Object { $_.Line })
$after += "redis graph cache keys: " + (docker exec relativa-redis sh -c "redis-cli --scan --pattern 'relativa-graph:graph:v1:*' | wc -l" 2>&1)
if ($writes) {
    $n = Count-TestEntities
    $after += "entities created by this run (first_name = Lab5WriteTest): $n"
    Reset-TestData
    $after += "deleted them and their audit_outbox rows (Reset-TestData); settle wait before this run: $settle s"
}
$after | Tee-Object -FilePath "$dir/after.run$Run.txt"
Get-Content $out | Select-Object -Last 34






