# Staged ramp-up demo: ONE k6 run per scenario that steps through 10 -> 25 -> 50 -> 100 -> 200 VUs (load-tests/lab5/staged-demo.js).
#
#   powershell -File high-load-systems/evidence/lab5/scripts/run-staged.ps1 -Scenario A
#
# Same protocol as run-k6.ps1 (k6 in a container on the compose network, ML queue purge, cache flush, entity cleanup),
# but the output is k6/staged/scenario-x/{summary.json,k6-output.txt,table.md}. table.md is built with staged-table.ps1.
param(
    [Parameter(Mandatory)] [ValidateSet('A', 'B', 'C')] [string] $Scenario,
    [string] $BaseUrl = 'http://relativa-graph-lb',
    [int] $StageSeconds = 40,
    [int] $StageRamp = 10
)
$ErrorActionPreference = 'Continue'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
Set-Location $repo
$dir = "high-load-systems/evidence/lab5/k6/staged/scenario-$($Scenario.ToLower())"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$stats = '--summary-trend-stats=avg,min,med,max,p(90),p(95),p(99)'
$writes = $Scenario -ne 'A'

. "$PSScriptRoot\lab5-lib.ps1"

"reset test data, purge queues, wait until idle, flush cache"
Reset-TestData
Purge-Queues
"settled after $(Wait-Settled) s"
docker exec relativa-redis sh -c "redis-cli --scan --pattern 'relativa-graph:graph:v1:*' | xargs -r redis-cli del" 2>&1 | Out-Null
Start-Sleep -Seconds 5

"k6 staged, scenario $Scenario (about $([int](15 + 5 * $StageSeconds)) s + graceful stop)"
$outMount = Join-Path $repo $dir
docker run --rm --name lab5-k6 --network relativa_relativa_net `
    -v "$($repo)\load-tests:/lt:ro" -v "${outMount}:/out" grafana/k6:latest `
    run -q $stats -e "BASE_URL=$BaseUrl" -e "SCENARIO=$Scenario" -e "STAGE=$StageSeconds" -e "STAGE_RAMP=$StageRamp" `
    '--summary-export=/out/summary.json' /lt/lab5/staged-demo.js 2>&1 | Out-File -Encoding utf8 "$dir/k6-output.txt"

if ($writes) { Reset-TestData }
$hold = $StageSeconds - $StageRamp
& powershell -NoProfile -File (Join-Path $PSScriptRoot 'staged-table.ps1') -Summary "$dir/summary.json" -StageSeconds $hold |
    Tee-Object -FilePath "$dir/table.md"

