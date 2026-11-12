# Prints the "measured stats" markdown table (A vs B, with % delta) for two Lab 5 k6 --summary-export files.
# Lab 5 version of evidence/lab4/k6/compare-summaries.ps1: it reads the custom metrics of load-tests/lab5/lib/common.js
# (m_reqs, m_failed, m_dur, m_dur_ok), which are recorded only during the HOLD of a run (the ramp-up is not measured).
# Throughput = m_reqs / HoldSeconds (default 60).
#
# Usage (from the repo root):
#   powershell -File high-load-systems/evidence/lab5/k6/compare-summaries.ps1 `
#       -Pre high-load-systems/evidence/lab5/k6/scaling/1-instance/summary.run1.json `
#       -Post high-load-systems/evidence/lab5/k6/scaling/3-instances/summary.run1.json `
#       [-PreLabel '1 instance'] [-PostLabel '3 instances']
#
# Change % = (post - pre) / pre * 100 (raw direction). Improvement % = the same number with the sign flipped for
# "lower is better" metrics (latency, errors), so positive always means better and negative always means worse.
# The summary files must have been produced with --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)".

param(
    [Parameter(Mandatory)] [string] $Pre,
    [Parameter(Mandatory)] [string] $Post,
    [string] $PreLabel = 'Pre',
    [string] $PostLabel = 'Post',
    [int] $HoldSeconds = 60
)

$a = (Get-Content $Pre -Raw | ConvertFrom-Json).metrics
$b = (Get-Content $Post -Raw | ConvertFrom-Json).metrics
$inv = [Globalization.CultureInfo]::InvariantCulture

function Fmt($v, $unit) {
    switch ($unit) {
        'ms'    { return ($v.ToString('0.0', $inv) + ' ms') }
        'req/s' { return ($v.ToString('0.00', $inv) + ' req/s') }
        'pct'   { return ($v.ToString('0.00', $inv) + ' %') }
        default { return $v.ToString('0', $inv) }
    }
}

# $getter: scriptblock (metrics) -> double
function Row($label, $getter, $unit, $direction) {
    $x = [double](& $getter $a)
    $y = [double](& $getter $b)
    if ($x -eq 0) { $delta = 'n/a'; $impr = 'n/a'; $verdict = if ($y -eq 0) { 'same' } else { 'n/a' } }
    else {
        $d = ($y - $x) / $x * 100
        $delta = ('{0:+0.0;-0.0;0.0}%' -f $d)
        $impr = if ($direction -eq 'info') { '-' } else { $s = if ($direction -eq 'lower') { -$d } else { $d }; ('{0:+0.0;-0.0;0.0}%' -f $s) }
        if ($direction -eq 'info') { $verdict = '-' }
        elseif ([math]::Abs($d) -lt 2) { $verdict = 'same (within 2%)' }
        elseif (($direction -eq 'lower') -eq ($d -lt 0)) { $verdict = 'better' }
        else { $verdict = 'worse' }
    }
    "| $label | $(Fmt $x $unit) | $(Fmt $y $unit) | $delta | $impr | $verdict |"
}
function Cnt($m, $name) { if ($null -ne $m.$name) { [double]$m.$name.count } else { 0 } }

"| Metric | $PreLabel | $PostLabel | Change % | Improvement % | Verdict |"
"|---|---:|---:|---:|---:|---|"
Row 'Requests in the hold'              { param($m) Cnt $m 'm_reqs' }                               ''      'higher'
Row 'Throughput'                        { param($m) (Cnt $m 'm_reqs') / $HoldSeconds }               'req/s' 'higher'
Row 'Latency avg (all requests)'        { param($m) $m.m_dur.avg }                                   'ms'    'lower'
Row 'Latency min'                       { param($m) $m.m_dur.min }                                   'ms'    'lower'
Row 'Latency median (p50)'              { param($m) $m.m_dur.med }                                   'ms'    'lower'
Row 'Latency p90'                       { param($m) $m.m_dur.'p(90)' }                               'ms'    'lower'
Row 'Latency p95'                       { param($m) $m.m_dur.'p(95)' }                               'ms'    'lower'
Row 'Latency p99'                       { param($m) $m.m_dur.'p(99)' }                               'ms'    'lower'
Row 'Latency max'                       { param($m) $m.m_dur.max }                                   'ms'    'lower'
Row 'Latency p95 (HTTP 200 only)'       { param($m) $m.m_dur_ok.'p(95)' }                            'ms'    'lower'
Row 'Latency p99 (HTTP 200 only)'       { param($m) $m.m_dur_ok.'p(99)' }                            'ms'    'lower'
Row 'Failed requests (status != 200)'   { param($m) Cnt $m 'm_failed' }                              ''      'lower'
Row 'Error rate'                        { param($m) $(if ((Cnt $m 'm_reqs') -gt 0) { (Cnt $m 'm_failed') / (Cnt $m 'm_reqs') * 100 } else { 0 }) } 'pct' 'lower'
