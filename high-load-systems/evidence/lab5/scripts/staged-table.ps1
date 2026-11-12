# Turns the per-stage custom metrics of load-tests/lab5/staged-demo.js into the ladder table (one row per stage).
#
#   powershell -File high-load-systems/evidence/lab5/scripts/staged-table.ps1 `
#       -Summary high-load-systems/evidence/lab5/k6/staged/scenario-a/summary.json -StageSeconds 30
#
# Throughput = requests recorded in the stage / StageSeconds (requests still in flight when the stage ends are
# interrupted and not counted, so this is a slight under-estimate when latency is high).
param(
    [Parameter(Mandatory)] [string] $Summary,
    [int] $StageSeconds = 30,
    [int[]] $Levels = @(10, 25, 50, 100, 200)
)
$inv = [Globalization.CultureInfo]::InvariantCulture
function F($v, $fmt) { ([double]$v).ToString($fmt, $inv) }
$m = (Get-Content $Summary -Raw | ConvertFrom-Json).metrics

"| Load (VUs) | Throughput (RPS) | Avg latency | p50 latency | p95 latency | p99 latency | Max latency | Error rate (%) | Errors / requests |"
"|---:|---:|---:|---:|---:|---:|---:|---:|---:|"
foreach ($n in $Levels) {
    $d = $m."stage_dur_$n"
    $req = [int]$m."stage_req_$n".count
    $errMetric = $m."stage_err_$n"
    $err = if ($null -ne $errMetric) { [int]$errMetric.count } else { 0 }
    $pct = if ($req -gt 0) { $err / $req * 100 } else { 0 }
    "| $n | $(F ($req / $StageSeconds) '0.0') | $(F $d.avg '0.0') ms | $(F $d.med '0.0') ms | $(F $d.'p(95)' '0.0') ms | $(F $d.'p(99)' '0.0') ms | $(F $d.max '0') ms | $(F $pct '0.00') | $err / $req |"
}
