# Lab 3 - GET /health: what the endpoint returns, what happens when PostgreSQL is lost, and recovery.
#
# Part A  /health on every instance (direct ports) and through the load balancer: 200 + JSON with the "postgres" check.
# Part B  PostgreSQL is stopped. /health must turn 503 "Unhealthy" on every instance. For comparison a normal API
#         request through nginx is sent as well: it fails with 500 (not retried, see the note in the output).
# Part C  PostgreSQL is started again. /health must return to 200 without restarting any Graph instance.
#
# Usage (from repo root):
#   powershell -File high-load-systems/evidence/lab3/scripts/health-check-demo.ps1

. "$PSScriptRoot\common.ps1"
function Say([string]$m) { "[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $m }

$instances = [ordered]@{ 'graph-1' = 'http://localhost:8083'; 'graph-2' = 'http://localhost:8085'; 'graph-3' = 'http://localhost:8086' }

function Show-Health([string] $label, [string] $base) {
    $body = & curl.exe -s -m 10 -w ' HTTP %{http_code}' "$base/health"
    "{0,-8} GET {1}/health -> {2}" -f $label, $base, (($body -join ' ') -replace '\s+', ' ')
}

"=== Part A: healthy system ==="
foreach ($k in $instances.Keys) { Show-Health $k $instances[$k] }
$viaLb = 1..6 | ForEach-Object { Get-Probe "$script:Lb/health" }
"via load balancer, 6 x GET /health: " + (($viaLb | Group-Object Status, Instance | Sort-Object Name | ForEach-Object { "{0} x{1}" -f ($_.Name -replace ', ', ' / HTTP '), $_.Count }) -join ';  ')
"load balancer own liveness: " + ((& curl.exe -s "$script:Lb/lb-status") -join '')

""
"=== Part B: PostgreSQL stopped ==="
Say 'docker stop relativa-postgres'
docker stop relativa-postgres | Out-Null
Start-Sleep -Seconds 3
foreach ($k in $instances.Keys) { Show-Health $k $instances[$k] }
$api = 1..3 | ForEach-Object { Get-Probe "$script:Lb$script:GraphUrl" -Graph }
"API request via load balancer while the DB is down: " + (($api | Group-Object Status | ForEach-Object { "HTTP {0} x{1}" -f $_.Name, $_.Count }) -join ';  ')
"NOTE: nginx community only does PASSIVE checks and it never calls /health. An application error status (here the global"
"      exception handler answers 409) is not in proxy_next_upstream, so nginx keeps sending traffic to a node whose DB"
"      is gone. Detecting that needs an ACTIVE check on /health"
"      (HAProxy 'option httpchk', nginx Plus, Kubernetes readinessProbe). Here every node loses the same shared DB anyway."

""
"=== Part C: PostgreSQL started again ==="
Say 'docker start relativa-postgres'
docker start relativa-postgres | Out-Null
$ok = Wait-Http "$($instances['graph-1'])/health" 90
Say "graph-1 /health back to 200: $ok"
foreach ($k in $instances.Keys) { Show-Health $k $instances[$k] }
$api = 1..3 | ForEach-Object { Get-Probe "$script:Lb$script:GraphUrl" -Graph }
"API request via load balancer after recovery: " + (($api | Group-Object Status | ForEach-Object { "HTTP {0} x{1}" -f $_.Name, $_.Count }) -join ';  ')
