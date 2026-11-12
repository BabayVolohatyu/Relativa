# Builds the "load ladder" markdown table of lab section 2.4 from k6 --summary-export files.
#
# Usage (from the repo root):
#   powershell -File high-load-systems/evidence/lab5/k6/build-baseline-table.ps1 -Dir high-load-systems/evidence/lab5/k6/scenario-a
#   (reads <Dir>/vus-<N>/summary.run<Run>.json for N in -Levels, default 10,50,100,200; -Run default 1)
#   -Metric m_dur (default) = latency of ALL requests of the measurement window (a 30 s timeout counts as 30 s)
#   -Metric m_dur_ok        = latency of the successful (HTTP 200) requests only
#
# The numbers come from the custom metrics of load-tests/lab5/lib/common.js, which are recorded ONLY during the HOLD
# (the ramp-up is not measured): m_reqs (count), m_failed (count of status != 200), m_dur / m_dur_ok (latency trends).
# Throughput = m_reqs / HoldSeconds (default 60).
#
# Columns: the seven of the lab (VUs, throughput, avg, p50, p95, p99, error rate) plus max latency, failed/total, and the
# two columns that show where the curve bends: "Linear ideal" = throughput of the previous level scaled by the VU ratio
# (what a system without a bottleneck would do in this closed loop) and "Efficiency" = measured / linear ideal.
# The summary files must have been produced with --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)".

param(
    [Parameter(Mandatory)] [string] $Dir,
    [int[]] $Levels = @(10, 50, 100, 200),
    [int] $Run = 1,
    [int] $HoldSeconds = 60,
    [string] $Metric = 'm_dur'
)
$inv = [Globalization.CultureInfo]::InvariantCulture
function F($v, $fmt) { ([double]$v).ToString($fmt, $inv) }

"| Load (VUs) | Throughput (RPS) | Avg latency | p50 latency | p95 latency | p99 latency | Max latency | Error rate (%) | Failed / total | Linear ideal (RPS) | Efficiency |"
"|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|"
$prevRps = $null
$prevVus = $null
foreach ($n in $Levels) {
    $file = Join-Path $Dir ("vus-{0}/summary.run{1}.json" -f $n, $Run)
    if (-not (Test-Path $file)) { "| $n VUs | (missing: $file) | | | | | | | | | |"; continue }
    $m = (Get-Content $file -Raw | ConvertFrom-Json).metrics
    $total = [int]$m.m_reqs.count
    $failed = if ($null -ne $m.m_failed) { [int]$m.m_failed.count } else { 0 }
    $rps = $total / $HoldSeconds
    $err = if ($total -gt 0) { $failed / $total * 100 } else { 0 }
    if ($null -eq $prevRps) { $ideal = '-'; $eff = '-' }
    else {
        $idealV = $prevRps * $n / $prevVus
        $ideal = F $idealV '0.0'
        $eff = (F ($rps / $idealV * 100) '0') + '%'
    }
    $d = $m.$Metric
    "| $n | $(F $rps '0.0') | $(F $d.avg '0.0') ms | $(F $d.med '0.0') ms | $(F $d.'p(95)' '0.0') ms | $(F $d.'p(99)' '0.0') ms | $(F $d.max '0') ms | $(F $err '0.00') | $failed / $total | $ideal | $eff |"
    $prevRps = $rps
    $prevVus = $n
}
