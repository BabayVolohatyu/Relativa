# Lab 4, defence step 1: Cache MISS -> HIT, cold vs hot latency, the key in Redis, TTL expiry.
#   powershell -File high-load-systems/evidence/lab4/scripts/cold-hot-demo.ps1 [-SkipExpiry]
param([switch] $SkipExpiry)
. "$PSScriptRoot\common.ps1"
$ErrorActionPreference = 'Continue'

'=== Lab 4 demo 1: Cache-Aside MISS -> HIT ==='
'Topology: nginx (Round Robin) -> graph-1/2/3 -> shared Redis + PostgreSQL. Request: GET /api/v1/graph?organizationId=1 (X-User-Id: 1)'
''
# Warm the JIT / connection pools of all three instances first, then delete the keys: the "cold" request below
# is then a real cache MISS (database + ML path), not a first-request-after-start artefact.
1..6 | ForEach-Object { Get-Graph | Out-Null }
Clear-CacheKeys
Show-CacheKeys 'before the first request'
''
'--- 1 cold request + 8 requests more (Round Robin: they land on graph-1, graph-2, graph-3, graph-1 ...)'
$first = Get-Graph
Format-Probe 'request 1 (cold)' $first
$hot = @()
2..9 | ForEach-Object { $r = Get-Graph; $hot += $r; Format-Probe "request $_" $r }
''
Show-CacheKeys 'after the requests'
''
$hits = @($hot | Where-Object { $_.XCache -eq 'HIT' })
$med = ($hits | Sort-Object Ms | ForEach-Object { $_.Ms })[[math]::Floor($hits.Count / 2)]
'SUMMARY  cold (MISS) = {0} ms   hot (HIT) median = {1} ms   HIT count = {2}/{3}   HITs served by instances: {4}' -f `
    $first.Ms, $med, $hits.Count, $hot.Count, (($hits | Group-Object Instance | ForEach-Object { $_.Name }) -join ', ')
'Same body in MISS and HIT: nodes={0}/{1} edges={2}/{3}' -f $first.Nodes, $hits[0].Nodes, $first.Edges, $hits[0].Edges

''
'--- 8 repeated cold/hot pairs (keys deleted before every cold request). The cold time varies because the ML scoring RPC'
'    (200 ms budget, 3 attempts) sometimes answers and sometimes times out; the hot time does not depend on it.'
$colds = @(); $hots = @()
1..8 | ForEach-Object {
    Clear-CacheKeys
    $c = Get-Graph; $h = Get-Graph
    $colds += $c.Ms; $hots += $h.Ms
    '{0}: cold {1,5} ms ({2})   hot {3,4} ms ({4})' -f $_, $c.Ms, $c.XCache, $h.Ms, $h.XCache
}
$sc = $colds | Sort-Object; $sh = $hots | Sort-Object
'cold: min={0} median={1} max={2} ms   hot: min={3} median={4} max={5} ms   -> median speed-up x{6:N0}' -f `
    $sc[0], $sc[3], $sc[-1], $sh[0], $sh[3], $sh[-1], ($sc[3] / [math]::Max(1, $sh[3]))

if (-not $SkipExpiry) {
    ''
    '--- Expiration (TTL, not invalidation): wait for the key to expire by itself'
    $key = (docker exec $script:Redis redis-cli --scan --pattern $script:KeyScan | Select-Object -First 1)
    $ttl = [int](docker exec $script:Redis redis-cli ttl $key)
    "key $key has $ttl s left; waiting $($ttl + 2) s ..."
    Start-Sleep -Seconds ($ttl + 2)
    Show-CacheKeys 'after the TTL elapsed'
    Format-Probe 'request after expiry' (Get-Graph)
    Format-Probe 'next request' (Get-Graph)
}
