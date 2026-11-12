# After run-plan-5.ps1: evidence for the write-path bottleneck and the staged demos of the write scenarios.
#   1  RabbitMQ churn probe: Scenario B, 50 VUs, 40 s hold (run-k6.ps1, output k6/diagnosis-rabbit-churn/) while the RabbitMQ
#      management API (/api/overview) is sampled every 5 s: connections / channels / queues created per second, publish rate.
#      Question: is every POST create a new connection + channel + queue (the RPC client in Graph), and how many per second?
#   2  staged demos: Scenario C, then B (10 -> 25 -> 50 -> 100 -> 200 VUs in one run)
# Waits for run-plan-5.ps1.  Log: evidence/lab5/logs/plan-6.log
param([int] $WaitForPid = 0)
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$s = $PSScriptRoot
. "$s\lab5-lib.ps1"
function Stamp($m) { "##### $m  $(Get-Date -Format HH:mm:ss)" }
if ($WaitForPid -gt 0) { "waiting for pid $WaitForPid"; Wait-Process -Id $WaitForPid -ErrorAction SilentlyContinue }

Stamp 'p6-1: RabbitMQ churn probe (B, 50 VUs, 40 s hold)'
$dir = 'high-load-systems/evidence/lab5/k6/diagnosis-rabbit-churn'
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$probeFile = Join-Path $repo "$dir/rabbit-overview.txt"
Remove-Item $probeFile -ErrorAction SilentlyContinue
$probe = Start-Job -ScriptBlock {
    param($file)
    Start-Sleep -Seconds 75   # warm-up (about 20 s) + reset/settle (about 25 s) + ramp-up (15 s) happen before this
    for ($i = 0; $i -lt 8; $i++) {
        $o = curl.exe -s -u relativa:relativa http://localhost:15672/api/overview | ConvertFrom-Json
        $c = $o.churn_rates
        "{0} conn_created/s={1:N1} channel_created/s={2:N1} queue_declared/s={3:N1} publish/s={4:N1} deliver_get/s={5:N1} connections={6} channels={7} queues={8}" -f (Get-Date -Format HH:mm:ss), $c.connection_created_details.rate, $c.channel_created_details.rate, $c.queue_declared_details.rate, $o.message_stats.publish_details.rate, $o.message_stats.get_no_ack_details.rate, $o.object_totals.connections, $o.object_totals.channels, $o.object_totals.queues | Out-File -Append -Encoding utf8 $file
        Start-Sleep -Seconds 5
    }
} -ArgumentList $probeFile
& powershell -NoProfile -File "$s\run-k6.ps1" -Scenario B -Vus 50 -OutDir 'diagnosis-rabbit-churn' -Run 1 -Duration 40s
Stop-Job $probe -ErrorAction SilentlyContinue; Remove-Job $probe -Force -ErrorAction SilentlyContinue

Stamp 'p6-2: staged demo, Scenario C'
& powershell -NoProfile -File "$s\run-staged.ps1" -Scenario C
Stamp 'p6-2: staged demo, Scenario B'
& powershell -NoProfile -File "$s\run-staged.ps1" -Scenario B

Reset-TestData
Stamp 'plan 6 done'

