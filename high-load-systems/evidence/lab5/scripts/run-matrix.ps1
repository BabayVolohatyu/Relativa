# Runs a whole part of the Lab 5 measurement plan by calling run-k6.ps1 for every cell (sequentially, never in parallel).
#
#   powershell -File high-load-systems/evidence/lab5/scripts/run-matrix.ps1 -Part main     [-Scenarios A,B,C] [-Levels 10,50,100,200] [-Run 1]
#   powershell -File high-load-systems/evidence/lab5/scripts/run-matrix.ps1 -Part scaling  [-Run 1]   # needs relativa-lab5-lb-1 (see nginx-1instance.conf)
#   powershell -File high-load-systems/evidence/lab5/scripts/run-matrix.ps1 -Part caching  [-Run 1]   # run once per side; the side is chosen with -Side
#
# main    : scenarios x levels on the 3-instance stack with the cache (8090)  -> k6/scenario-x/vus-N
# scaling : Scenario A at 100 VUs, 1 instance (relativa-lab5-lb-1) vs 3 instances (relativa-graph-lb) -> k6/scaling/1-instance, 3-instances
# caching : Scenario A at 50 VUs; -Side enabled (Lab 4 image) | disabled (relativa-graph-orig image) -> k6/caching/cache-enabled|cache-disabled
param(
    [Parameter(Mandatory)] [ValidateSet('main', 'scaling', 'caching')] [string] $Part,
    [string] $Scenarios = 'A,B,C',
    [string] $Levels = '10,50,100,200',
    [int] $Run = 1,
    [ValidateSet('enabled', 'disabled')] [string] $Side = 'enabled',
    [int] $ScalingVus = 100,
    [int] $CachingVus = 50
)
$runner = Join-Path $PSScriptRoot 'run-k6.ps1'
# -File passes "B,C" as ONE string, so lists are comma-separated strings (-Scenarios B,C -Levels 10,100)
$scenarioList = $Scenarios -split '[,\s]+' | Where-Object { $_ }
$levelList = $Levels -split '[,\s]+' | Where-Object { $_ } | ForEach-Object { [int]$_ }
switch ($Part) {
    'main' {
        foreach ($s in $scenarioList) {
            foreach ($n in $levelList) {
                "=== scenario $s, $n VUs, run $Run ==="
                & powershell -NoProfile -File $runner -Scenario $s -Vus $n -OutDir "scenario-$($s.ToLower())/vus-$n" -Run $Run
            }
        }
    }
    'scaling' {
        $sd = if ($ScalingVus -eq 100) { 'scaling' } else { "scaling-$ScalingVus" }
        "=== scaling: 1 instance, $ScalingVus VUs, run $Run ==="
        & powershell -NoProfile -File $runner -Scenario A -Vus $ScalingVus -OutDir "$sd/1-instance" -Run $Run -BaseUrl 'http://relativa-lab5-lb-1'
        "=== scaling: 3 instances, $ScalingVus VUs, run $Run ==="
        & powershell -NoProfile -File $runner -Scenario A -Vus $ScalingVus -OutDir "$sd/3-instances" -Run $Run -BaseUrl 'http://relativa-graph-lb'
    }
    'caching' {
        "=== caching: cache $Side, $CachingVus VUs, run $Run ==="
        & powershell -NoProfile -File $runner -Scenario A -Vus $CachingVus -OutDir "caching/cache-$Side" -Run $Run
    }
}


