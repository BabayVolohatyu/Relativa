# Extra measurements decided after the first results of run-plan.ps1 (a clean read run showed that Scenario A does NOT saturate
# up to 200 VUs with the cache on, and that run 1 of A/200 had been disturbed by ML work left over from the previous run):
#   1  Scenario A run 3 at 100, 200, 300, 500 VUs (clean-state protocol): second valid run at 100/200, and the ladder
#      continued until the cached read path saturates
#   2  Scenario A with the cache DISABLED (original image) at 10/50/100/200 VUs: the ladder of the uncached read path,
#      which is where the real bottleneck (ML + PostgreSQL connections) lives; then the Lab 4 images are restored
# Waits for the main plan (run-plan.ps1) to finish first.  Log: evidence/lab5/logs/plan-extra.log
param([int] $WaitForPid = 0)
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$s = $PSScriptRoot
. "$s\lab5-lib.ps1"
$compose = @('-f', 'docker-compose.yaml', '-f', 'docker-compose.lab2.yml', '-f', 'docker-compose.lab3.yml')
function Stamp($m) { "##### $m  $(Get-Date -Format HH:mm:ss)" }
if ($WaitForPid -gt 0) { "waiting for pid $WaitForPid"; Wait-Process -Id $WaitForPid -ErrorAction SilentlyContinue }

Stamp 'extra 1: Scenario A run 3 (100, 200, 300, 500 VUs)'
& powershell -NoProfile -File "$s\run-matrix.ps1" -Part main -Scenarios A -Levels 100, 200, 300, 500 -Run 3

Stamp 'extra 2: uncached ladder (original image)'
docker compose @compose -f high-load-systems/evidence/lab4/scripts/orig-image.override.yml up -d --no-build graph graph-2 graph-3 2>&1 | Out-Null
docker restart relativa-graph-lb | Out-Null
Start-Sleep -Seconds 25
curl.exe -s -D - -o NUL -H 'X-User-Id: 1' 'http://localhost:8090/api/v1/graph?organizationId=1' | Select-String 'HTTP|X-Cache|X-Instance'
foreach ($n in 10, 50, 100, 200) {
    "=== uncached, $n VUs ==="
    & powershell -NoProfile -File "$s\run-k6.ps1" -Scenario A -Vus $n -OutDir "uncached/vus-$n" -Run 1
}
Stamp 'restore the Lab 4 images'
docker compose @compose up -d --no-build graph graph-2 graph-3 2>&1 | Out-Null
docker restart relativa-graph-lb | Out-Null
Start-Sleep -Seconds 25
curl.exe -s -D - -o NUL -H 'X-User-Id: 1' 'http://localhost:8090/api/v1/graph?organizationId=1' | Select-String 'HTTP|X-Cache|X-Instance'
Reset-TestData
Stamp 'extra done'
