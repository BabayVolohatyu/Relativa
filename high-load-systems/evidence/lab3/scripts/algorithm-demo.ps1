# Lab 3 - Balancing algorithms: distribution by X-Instance-ID, Round Robin vs Least Connections, live switch.
#
# Part 1  A sequential burst (one request at a time) under the CURRENT nginx algorithm: with equal nodes
#         every algorithm distributes evenly.
# Part 2  A concurrent burst ($Concurrency requests in flight) with Round Robin, then the config is switched
#         LIVE (docker cp + nginx -s reload) to Least Connections and the same burst is repeated.
#         Run it with a slow instance (docker-compose.lab3-slow.yml, graph-2 = +500 ms) to see the difference:
#         Round Robin keeps sending a third of the traffic to the slow node, Least Connections sends it less.
#         With three equal nodes the two algorithms look the same (that is also a valid result).
#
# At the end nginx is left on Round Robin (the default of the lab stack).
#
# Usage (from repo root):
#   powershell -File high-load-systems/evidence/lab3/scripts/algorithm-demo.ps1 [-Count 90] [-Concurrency 15]

param(
    [int] $Count = 90,
    [int] $Concurrency = 15
)

. "$PSScriptRoot\common.ps1"

"=== Part 1: sequential burst, equal conditions, current algorithm ==="
Set-LbAlgorithm rr
$seq = 1..30 | ForEach-Object { Get-Probe "$script:Lb$script:GraphUrl" -Graph }
Show-Distribution $seq 'ROUND ROBIN, sequential'

""
"=== Part 2: concurrent burst ($Count requests, $Concurrency in flight) ==="
foreach ($alg in 'rr', 'lc') {
    Set-LbAlgorithm $alg
    $probes = Get-ParallelProbes "$script:Lb$script:GraphUrl" -Count $Count -Concurrency $Concurrency
    Show-Distribution $probes $(if ($alg -eq 'rr') { 'ROUND ROBIN, concurrent' } else { 'LEAST CONNECTIONS, concurrent' })
    ""
}

"=== restoring the default algorithm ==="
Set-LbAlgorithm rr
