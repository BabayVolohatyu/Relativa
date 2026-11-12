# Lab 3 (extra) - ACTIVE health check (HAProxy, :8091) vs PASSIVE health check (nginx, :8090) on a HUNG instance.
#
# "Hung" = the process is alive and the TCP port accepts connections, but nothing is ever answered
# (docker pause freezes the container: a stand-in for a deadlock, a GC storm or a stuck thread pool).
# This is the case where passive checks are weak: nginx only learns the node is bad by waiting for a real client
# request to time out (proxy_read_timeout 60 s), while HAProxy polls GET /health every 2 s and removes the node
# after 2 failed polls (about 4 s).
#
# Both balancers get the same sequential traffic (curl timeout 12 s) for $Duration seconds; graph-3 is frozen
# after 5 s and unfrozen after $FrozenSeconds. Needs the HAProxy overlay:
#   docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml `
#                  -f docker-compose.lab3-haproxy.yml up -d graph-lb-haproxy
#
# Usage (from repo root):
#   powershell -File high-load-systems/evidence/lab3/scripts/active-health-demo.ps1

param(
    [int] $Duration = 50,
    [int] $FrozenSeconds = 25
)

. "$PSScriptRoot\common.ps1"
function Say([string]$m) { "[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $m }

function Show-HaproxyServers {
    # CSV columns (HAProxy): 0 pxname, 1 svname, 17 status, 36 check_status. Parsed by index (the header has duplicate names).
    (& curl.exe -s -m 5 'http://localhost:8404/stats;csv') | ForEach-Object { $f = $_ -split ','; if ($f[0] -eq 'graph_pool' -and $f[1] -like 'graph-*') {
        "   HAProxy server {0}: {1} (last check: {2})" -f $f[1], $f[17], $f[36] } }
}

"=== HAProxy pool before the test ==="
Show-HaproxyServers

$probe = {
    param($url, $duration)
    $end = (Get-Date).AddSeconds($duration)
    while ((Get-Date) -lt $end) {
        $t = Get-Date
        $o = (& curl.exe -s -o NUL -m 12 -H 'X-User-Id: 1' -w '%{http_code} %header{x-instance-id} %{time_total}' $url) -split ' '
        [pscustomobject]@{ Time = $t; Status = [int]$o[0]; Instance = if ($o.Count -ge 3) { $o[1] } else { '' }
                           Sec = [double]::Parse($o[$o.Count - 1], [Globalization.CultureInfo]::InvariantCulture) }
        Start-Sleep -Milliseconds 100
    }
}
$jobNginx   = Start-Job -ScriptBlock $probe -ArgumentList "http://localhost:8090/api/v1/graph?organizationId=1", $Duration
$jobHaproxy = Start-Job -ScriptBlock $probe -ArgumentList "http://localhost:8091/api/v1/graph?organizationId=1", $Duration

Start-Sleep -Seconds 5
$frozenAt = Get-Date;   Say 'docker pause relativa-graph-3   (graph-3 hangs: accepts TCP, answers nothing)'; docker pause relativa-graph-3 | Out-Null
Start-Sleep -Seconds 10
"--- 10 s after the freeze"
Show-HaproxyServers
Start-Sleep -Seconds ($FrozenSeconds - 10)
$thawedAt = Get-Date;   Say 'docker unpause relativa-graph-3 (graph-3 answers again)'; docker unpause relativa-graph-3 | Out-Null
Start-Sleep -Seconds 8
"--- 8 s after the unfreeze"
Show-HaproxyServers
Wait-Job $jobNginx, $jobHaproxy | Out-Null
$rowsN = Receive-Job $jobNginx;  $rowsH = Receive-Job $jobHaproxy
Remove-Job $jobNginx, $jobHaproxy

function Summ($name, $rows) {
    $during = $rows | Where-Object { $_.Time -ge $frozenAt -and $_.Time -lt $thawedAt }
    $bad = @($during | Where-Object { $_.Status -ne 200 }).Count
    $slow = @($during | Where-Object { $_.Sec -gt 3 }).Count
    $max = ($during | Measure-Object Sec -Maximum).Maximum
    "{0,-22} during the freeze: {1,3} requests, {2,3} failed/timed out (non-200), {3,3} slower than 3 s, slowest {4:N1} s" -f $name, @($during).Count, $bad, $slow, $max
    "{0,-22} whole run       : {1,3} requests, {2,3} non-200" -f '', @($rows).Count, @($rows | Where-Object { $_.Status -ne 200 }).Count
    $firstBack = $rows | Where-Object { $_.Time -ge $thawedAt -and $_.Instance -eq 'graph-3' } | Sort-Object Time | Select-Object -First 1
    if ($firstBack) { "{0,-22} graph-3 served again {1:N1} s after the unfreeze" -f '', ($firstBack.Time - $thawedAt).TotalSeconds }
}
""
"=== RESULT (graph-3 frozen for $FrozenSeconds s) ==="
Summ 'nginx   (passive)' $rowsN
Summ 'HAProxy (active)'  $rowsH
