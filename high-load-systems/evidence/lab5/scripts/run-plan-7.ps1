# After run-plan-6.ps1: scaling at 300 VUs (1 instance vs 3 instances), one run each. At 200 VUs the cached read is still
# VUs / (think + latency)-bound for both sides; 300 VUs is where the 3-instance run of the main ladder degraded (173 req/s,
# p95 2.7 s) and it comes WITH the CPU stream this time (the earlier run 3 was made with the broken sampler).
# Waits for run-plan-6.ps1.  Log: evidence/lab5/logs/plan-7.log
param([int] $WaitForPid = 0)
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$s = $PSScriptRoot
. "$s\lab5-lib.ps1"
function Stamp($m) { "##### $m  $(Get-Date -Format HH:mm:ss)" }
if ($WaitForPid -gt 0) { "waiting for pid $WaitForPid"; Wait-Process -Id $WaitForPid -ErrorAction SilentlyContinue }

Stamp 'p7: scaling at 300 VUs, run 1'
docker rm -f relativa-lab5-lb-1 2>&1 | Out-Null
docker run -d --name relativa-lab5-lb-1 --network relativa_relativa_net `
    -v "$repo\high-load-systems\evidence\lab5\scripts\nginx-1instance.conf:/etc/nginx/conf.d/default.conf:ro" nginx:1.27-alpine
Start-Sleep -Seconds 3
& powershell -NoProfile -File "$s\run-matrix.ps1" -Part scaling -ScalingVus 300 -Run 1
docker rm -f relativa-lab5-lb-1 2>&1 | Out-Null
Reset-TestData
Stamp 'plan 7 done'
