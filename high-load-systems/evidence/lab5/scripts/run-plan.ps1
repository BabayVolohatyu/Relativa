# The Lab 5 measurement plan (version 2, after the contaminated attempt), strictly sequential, READ-ONLY runs first and
# WRITE runs last, each run starting from a cleaned and idle system (see lab5-lib.ps1). Log: evidence/lab5/logs/plan.log
#
#   powershell -File high-load-systems/evidence/lab5/scripts/run-plan.ps1
#
# Order:
#   0  one-time full cleanup (delete all test entities, audit_outbox rows, VACUUM FULL), purge queues, wait until idle
#   1  READ-ONLY: Scenario A pass 2 (pass 1 was recorded earlier on the clean system and is kept)
#   2  READ-ONLY: scaling, Scenario A at 100 VUs, 1 instance vs 3 instances, 2 runs each
#   3  READ-ONLY: staged ramp-up demo, Scenario A
#   4  READ-ONLY: caching, cache DISABLED side (original image), 2 runs, then restore the Lab 4 images
#   5  WRITE: Scenarios B and C, pass 1 (10/50/100/200 VUs), pass 2 (10 and 100 VUs)
# The cache-ENABLED side of the caching experiment is Scenario A at 50 VUs from the main table.
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$s = $PSScriptRoot
. "$s\lab5-lib.ps1"
$compose = @('-f', 'docker-compose.yaml', '-f', 'docker-compose.lab2.yml', '-f', 'docker-compose.lab3.yml')
function Stamp($m) { "##### $m  $(Get-Date -Format HH:mm:ss)" }

Stamp '0 full cleanup'
Reset-TestData -Full
Purge-Queues
"settled after $(Wait-Settled) s"
"entities: " + (Invoke-Psql 'select count(*) from entity') + ", audit_outbox: " + (Invoke-Psql 'select count(*) from audit_outbox')

Stamp '1 Scenario A, pass 2'
& powershell -NoProfile -File "$s\run-matrix.ps1" -Part main -Scenarios A -Run 2

Stamp '2 scaling'
docker rm -f relativa-lab5-lb-1 2>&1 | Out-Null
docker run -d --name relativa-lab5-lb-1 --network relativa_relativa_net `
    -v "$repo\high-load-systems\evidence\lab5\scripts\nginx-1instance.conf:/etc/nginx/conf.d/default.conf:ro" nginx:1.27-alpine
Start-Sleep -Seconds 3
foreach ($r in 1, 2) { & powershell -NoProfile -File "$s\run-matrix.ps1" -Part scaling -Run $r }
docker rm -f relativa-lab5-lb-1 2>&1 | Out-Null

Stamp '3 staged demo A'
& powershell -NoProfile -File "$s\run-staged.ps1" -Scenario A

Stamp '4 caching: cache DISABLED side (original image)'
docker compose @compose -f high-load-systems/evidence/lab4/scripts/orig-image.override.yml up -d --no-build graph graph-2 graph-3 2>&1 | Out-Null
docker restart relativa-graph-lb | Out-Null
Start-Sleep -Seconds 25
curl.exe -s -D - -o NUL -H 'X-User-Id: 1' 'http://localhost:8090/api/v1/graph?organizationId=1' | Select-String 'HTTP|X-Cache|X-Instance'
foreach ($r in 1, 2) { & powershell -NoProfile -File "$s\run-matrix.ps1" -Part caching -Side disabled -Run $r }
Stamp 'restore the Lab 4 images'
docker compose @compose up -d --no-build graph graph-2 graph-3 2>&1 | Out-Null
docker restart relativa-graph-lb | Out-Null
Start-Sleep -Seconds 25
curl.exe -s -D - -o NUL -H 'X-User-Id: 1' 'http://localhost:8090/api/v1/graph?organizationId=1' | Select-String 'HTTP|X-Cache|X-Instance'

Stamp '5 WRITE scenarios B and C, pass 1'
& powershell -NoProfile -File "$s\run-matrix.ps1" -Part main -Scenarios B, C -Run 1
Stamp '5 WRITE scenarios B and C, pass 2 (10 and 100 VUs)'
& powershell -NoProfile -File "$s\run-matrix.ps1" -Part main -Scenarios B, C -Levels 10, 100 -Run 2

Reset-TestData
Stamp 'all done'
