# Lab 4, defence step 3: Redis is killed -> the system keeps answering from PostgreSQL (X-Cache: BYPASS), then Redis returns.
#   powershell -File high-load-systems/evidence/lab4/scripts/fallback-demo.ps1
# Requires the Lab 3/4 stack (nginx :8090, 3 Graph instances, Redis). Redis is started again at the end (also on error).
. "$PSScriptRoot\common.ps1"
$ErrorActionPreference = 'Continue'

'=== Lab 4 demo 3: Redis failure (graceful degradation) ==='
1..6 | ForEach-Object { Get-Graph | Out-Null }
Format-Probe 'redis UP   request 1' (Get-Graph)
Format-Probe 'redis UP   request 2' (Get-Graph)
''
'--- docker stop relativa-redis'
docker stop $script:Redis | Out-Null
try {
    $res = @()
    foreach ($i in 1..12) {
        $r = Get-Graph
        $res += $r
        Format-Probe "redis DOWN request $i" $r
    }
    $bad = @($res | Where-Object { $_.Status -ne 200 }).Count
    $bypass = @($res | Where-Object { $_.XCache -eq 'BYPASS' }).Count
    $ms = @($res | Sort-Object Ms | ForEach-Object { $_.Ms })
    ''
    'SUMMARY while Redis is down: non-200 = {0}/12, X-Cache=BYPASS = {1}/12, latency min/median/max = {2}/{3}/{4} ms' -f `
        $bad, $bypass, $ms[0], $ms[6], $ms[-1]
    $h = & curl.exe -s -o NUL -w '%{http_code}' 'http://localhost:8083/health'
    "GET /health on graph-1 (PostgreSQL check) while Redis is down: HTTP $h"
    ''
    '--- A WRITE while Redis is down: invalidation is best effort, so the create must still succeed'
    $file = Join-Path $env:TEMP 'lab4-create.json'
    '{"entityTypeId":1,"properties":[{"propertyId":1,"value":"CacheDemo"},{"propertyId":3,"value":"Probe"}]}' | Out-File -Encoding ascii $file
    $resp = & curl.exe -s -m 60 -w '|HTTP %{http_code} %{time_total}s' -X POST -H 'X-User-Id: 1' -H 'Content-Type: application/json' --data-binary "@$file" "$($script:Lb)/api/v1/workspaces/1/entity-graph/create"
    $newId = ([regex]::Match($resp, '^\{"id":(\d+)')).Groups[1].Value
    "create answer: id=$newId  $($resp.Substring($resp.LastIndexOf('|') + 1))"
    if ($newId) {
        docker exec relativa-postgres psql -U relativa -d relativa -c "update entity set is_archived = true where id = $newId" | Out-Null
        "cleanup: entity $newId archived."
    }
    ''
    '--- Graph log (last cache warnings):'
    foreach ($c in 'relativa-graph', 'relativa-graph-2', 'relativa-graph-3') {
        docker logs $c --since 2m 2>&1 | Select-String 'Graph cache' | Select-Object -Last 2 | ForEach-Object { "    [$c] " + $_.Line.Trim() }
    }
}
finally {
    ''
    '--- docker start relativa-redis'
    docker start $script:Redis | Out-Null
}

# Recovery: every instance has its own connection and reconnects on its own; watch until all answer without BYPASS.
$sw = [Diagnostics.Stopwatch]::StartNew()
$streak = 0
$n = 0
while ($sw.Elapsed.TotalSeconds -lt 90 -and $streak -lt 9) {
    $n++
    $r = Get-Graph
    Format-Probe ('{0,5:N1}s after start, request {1}' -f $sw.Elapsed.TotalSeconds, $n) $r
    if ($r.XCache -eq 'BYPASS' -or $r.Status -ne 200) { $streak = 0 } else { $streak++ }
    Start-Sleep -Milliseconds 700
}
'recovery: {0} consecutive answers without BYPASS (3 per instance) reached {1:N1} s after "docker start"' -f $streak, $sw.Elapsed.TotalSeconds
