# Last part of the Lab 5 measurements (after run-plan.ps1 and run-plan-extra.ps1; see CONTEXT.md for why there are several):
# run-plan.ps1 failed at its WRITE block because `powershell -File` passes "B, C" as ONE string to a string[]/int[] parameter
# (run-matrix.ps1 now takes comma-separated strings), and a 500-VU read run wedged Docker Desktop (engine HTTP 500).
#   1  WRITE: Scenarios B and C, pass 1 (10/50/100/200 VUs), pass 2 (10 and 100 VUs)
#   2  PostgreSQL load with / without the cache (run-k6.ps1 saves pg_stat_database deltas): A/50 cached run 3,
#      then A/50 with the cache disabled (original image) runs 2 and 3; the Lab 4 images are restored afterwards
#   3  scaling at 200 VUs (saturating zone of the cached read), 1 instance vs 3 instances, 2 runs each
# Log: evidence/lab5/logs/plan-5.log
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$s = $PSScriptRoot
. "$s\lab5-lib.ps1"
$compose = @('-f', 'docker-compose.yaml', '-f', 'docker-compose.lab2.yml', '-f', 'docker-compose.lab3.yml')
function Stamp($m) { "##### $m  $(Get-Date -Format HH:mm:ss)" }

Stamp 'p5-1: WRITE scenarios B and C, pass 1'
& powershell -NoProfile -File "$s\run-matrix.ps1" -Part main -Scenarios B,C -Run 1
Stamp 'p5-1: WRITE scenarios B and C, pass 2 (10 and 100 VUs)'
& powershell -NoProfile -File "$s\run-matrix.ps1" -Part main -Scenarios B,C -Levels 10,100 -Run 2

Stamp 'p5-2: cache enabled, A/50, run 3 (with PostgreSQL counters)'
& powershell -NoProfile -File "$s\run-k6.ps1" -Scenario A -Vus 50 -OutDir 'scenario-a/vus-50' -Run 3
Stamp 'p5-2: cache disabled (original image), A/50, runs 2 and 3'
docker compose @compose -f high-load-systems/evidence/lab4/scripts/orig-image.override.yml up -d --no-build graph graph-2 graph-3 2>&1 | Out-Null
docker restart relativa-graph-lb | Out-Null
Start-Sleep -Seconds 25
curl.exe -s -D - -o NUL -H 'X-User-Id: 1' 'http://localhost:8090/api/v1/graph?organizationId=1' | Select-String 'HTTP|X-Cache|X-Instance'
foreach ($r in 2, 3) { & powershell -NoProfile -File "$s\run-k6.ps1" -Scenario A -Vus 50 -OutDir 'uncached/vus-50' -Run $r }
Stamp 'p5-2: restore the Lab 4 images'
docker compose @compose up -d --no-build graph graph-2 graph-3 2>&1 | Out-Null
docker restart relativa-graph-lb | Out-Null
Start-Sleep -Seconds 25
curl.exe -s -D - -o NUL -H 'X-User-Id: 1' 'http://localhost:8090/api/v1/graph?organizationId=1' | Select-String 'HTTP|X-Cache|X-Instance'

Stamp 'p5-3: scaling at 200 VUs'
docker rm -f relativa-lab5-lb-1 2>&1 | Out-Null
docker run -d --name relativa-lab5-lb-1 --network relativa_relativa_net `
    -v "$repo\high-load-systems\evidence\lab5\scripts\nginx-1instance.conf:/etc/nginx/conf.d/default.conf:ro" nginx:1.27-alpine
Start-Sleep -Seconds 3
foreach ($r in 1, 2) { & powershell -NoProfile -File "$s\run-matrix.ps1" -Part scaling -ScalingVus 200 -Run $r }
docker rm -f relativa-lab5-lb-1 2>&1 | Out-Null

Reset-TestData
Stamp 'plan 5 done'
