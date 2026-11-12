# Lab 3 - Fault tolerance: one Graph instance is stopped under live traffic.
#
# Four parallel client loops send GET /api/v1/graph through the load balancer (nginx, :8090) for ~$Duration seconds.
# After 8 s the chosen instance is stopped (docker kill = SIGKILL, or docker stop = graceful), it stays dead for
# $DeadSeconds seconds, then it is started again. Expected:
#   * 0 responses other than 200 (nginx marks the dead server as failed and retries the request on another one),
#   * while the instance is dead only the surviving instances answer,
#   * after the restart the instance receives traffic again by itself (passive health check recovery,
#     fail_timeout=10s), without anybody touching nginx.
# The nginx access log lines that show a retry (two addresses in "upstream=") are printed at the end.
#
# Usage (from repo root):
#   powershell -File high-load-systems/evidence/lab3/scripts/fault-tolerance-demo.ps1 [-Mode kill|stop] [-Victim graph-2]

param(
    [ValidateSet('kill', 'stop')] [string] $Mode = 'kill',
    [ValidateSet('graph', 'graph-2', 'graph-3')] [string] $Victim = 'graph-2',
    [int] $Duration = 50,
    [int] $DeadSeconds = 20
)

. "$PSScriptRoot\common.ps1"
function Say([string]$m) { "[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $m }

$container = "relativa-$Victim"
$instanceId = switch ($Victim) { 'graph' { 'graph-1' } default { $Victim } }

"=== Fault tolerance: $Mode $container under traffic through the load balancer ($script:Lb) ==="
$since = Get-Date

$jobs = 1..4 | ForEach-Object {
    Start-Job -ArgumentList $script:Lb, $Duration -ScriptBlock {
        param($lb, $duration)
        $end = (Get-Date).AddSeconds($duration)
        while ((Get-Date) -lt $end) {
            $t = Get-Date
            $out = (& curl.exe -s -o NUL -m 30 -H 'X-User-Id: 1' -w '%{http_code} %header{x-instance-id}' "$lb/api/v1/graph?organizationId=1") -split ' '
            [pscustomobject]@{ Time = $t; Status = [int]$out[0]; Instance = if ($out.Count -ge 2) { $out[1] } else { '' } }
            Start-Sleep -Milliseconds 100
        }
    }
}

Start-Sleep -Seconds 8
$killedAt = Get-Date
Say "docker $Mode $container   (instance $instanceId lost)"
if ($Mode -eq 'kill') { docker kill $container | Out-Null } else { docker stop $container | Out-Null }
Start-Sleep -Seconds $DeadSeconds
$startedAt = Get-Date
Say "docker start $container  (instance $instanceId back)"
docker start $container | Out-Null
$jobs | Wait-Job | Out-Null
$rows = $jobs | Receive-Job
$jobs | Remove-Job

$before = $rows | Where-Object { $_.Time -lt $killedAt }
$during = $rows | Where-Object { $_.Time -ge $killedAt -and $_.Time -lt $startedAt }
$after  = $rows | Where-Object { $_.Time -ge $startedAt }
function Summ($set) { ($set | Group-Object Instance, Status | Sort-Object Name | ForEach-Object { "{0} x{1}" -f ($_.Name -replace ', ', ' / HTTP '), $_.Count }) -join ';  ' }
""
"before $Mode   ({0,4} requests): {1}" -f @($before).Count, (Summ $before)
"instance dead ({0,4} requests): {1}" -f @($during).Count, (Summ $during)
"after restart ({0,4} requests): {1}" -f @($after).Count, (Summ $after)
$failed = @($rows | Where-Object { $_.Status -ne 200 }).Count
$servedWhileDead = @($during | Where-Object { $_.Instance -eq $instanceId }).Count
""
"RESULT total requests={0}  non-200={1}  served-by-$instanceId-while-dead={2}" -f @($rows).Count, $failed, $servedWhileDead
$firstBack = $after | Where-Object { $_.Instance -eq $instanceId } | Sort-Object Time | Select-Object -First 1
if ($firstBack) { "RESULT $instanceId served its first request again {0:N1} s after docker start (no manual nginx action)" -f ($firstBack.Time - $startedAt).TotalSeconds }
else { "RESULT $instanceId did NOT receive traffic again within the run" }

""
"--- nginx access-log lines where nginx retried on another upstream (upstream=a, b) ---"
$retried = docker logs $script:LbName --since $since.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ') 2>&1 | Select-String -Pattern 'upstream=\S+, '
"retried requests: $(@($retried).Count)"
$retried | Select-Object -First 6 | ForEach-Object { $_.Line }
