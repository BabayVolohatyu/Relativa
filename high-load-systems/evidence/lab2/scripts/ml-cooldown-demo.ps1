# Lab 2 - proves where the "ML recalculation cooldown" (5 min per workspace) lives.
#
# GET /api/v1/dashboard/workspace/{id}/risk-distribution enqueues an ML recalculation job when deals have no score,
# but only if no job was enqueued for this workspace in the last 5 minutes (cooldown key).
# We call the endpoint once on Graph instance 1 and once on Graph instance 2 and count how many
# "ml.recalculate.enqueued" messages were published to RabbitMQ (a temporary tap queue counts them).
#
#   cooldown in IMemoryCache (per process)  -> instance 2 does not see instance 1's key -> 2 jobs (BUG: duplicate work)
#   cooldown in Redis (IDistributedCache)   -> instance 2 sees the key                  -> 1 job
#
# Usage:  powershell -File high-load-systems/evidence/lab2/scripts/ml-cooldown-demo.ps1 [-WorkspaceId 3]

param(
    [int]$WorkspaceId = 3,
    [string]$Instance1 = 'http://localhost:8083',
    [string]$Instance2 = 'http://localhost:8085',
    [string]$Mgmt = 'http://localhost:15672',
    [bool]$StopMl = $true,
    [string]$MlContainer = 'relativa-ml'
)

$h = @{ Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('relativa:relativa')) }
$queue = 'lab2.tap.enqueued'

# Fresh tap queue bound to the enqueue routing key.
try { Invoke-RestMethod -Method Delete -Headers $h -Uri "$Mgmt/api/queues/%2F/$queue" | Out-Null } catch {}
Invoke-RestMethod -Method Put -Headers $h -Uri "$Mgmt/api/queues/%2F/$queue" -ContentType 'application/json' -Body '{"durable":false,"auto_delete":false}' | Out-Null
Invoke-RestMethod -Method Post -Headers $h -Uri "$Mgmt/api/bindings/%2F/e/relativa.domain/q/$queue" -ContentType 'application/json' -Body '{"routing_key":"ml.recalculate.enqueued"}' | Out-Null

# The job is only enqueued while deals have no ML score. Once ML has scored a workspace nothing is enqueued
# any more, which would make this demo non-repeatable. Stopping the ML container makes scoring time out
# ("ml_scoring_degraded"), i.e. deals look unscored, exactly like on a cold start.
if ($StopMl) { docker stop $MlContainer | Out-Null; Write-Output "ML container '$MlContainer' stopped for the duration of the probe (deals look unscored)." }
try {
    foreach ($base in $Instance1, $Instance2) {
        $r = Invoke-WebRequest -UseBasicParsing -Headers @{ 'X-User-Id' = '1' } -Uri "$base/api/v1/dashboard/workspace/$WorkspaceId/risk-distribution"
        $iid = $r.Headers['X-Instance-ID']; if (-not $iid) { $iid = '<header not present>' }
        Write-Output ("GET {0}/api/v1/dashboard/workspace/{1}/risk-distribution -> HTTP {2}  X-Instance-ID={3}" -f $base, $WorkspaceId, $r.StatusCode, $iid)
    }
}
finally {
    if ($StopMl) { docker start $MlContainer | Out-Null; Write-Output "ML container '$MlContainer' started again." }
}

# RabbitMQ management stats are refreshed every few seconds.
$deadline = (Get-Date).AddSeconds(15); $count = 0
do { Start-Sleep -Seconds 2; $count = (Invoke-RestMethod -Headers $h -Uri "$Mgmt/api/queues/%2F/$queue").messages } while ((Get-Date) -lt $deadline -and $count -lt 2)

Invoke-RestMethod -Method Delete -Headers $h -Uri "$Mgmt/api/queues/%2F/$queue" | Out-Null
Write-Output ""
Write-Output "RESULT ml.recalculate.enqueued messages published for workspace ${WorkspaceId}: $count   (correct shared cooldown => 1, per-instance cooldown => 2)"
