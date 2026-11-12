# Prints the "measured stats" markdown table (A vs B, with % delta) for two k6 --summary-export files.
# Lab 3 version of evidence/lab2/k6/compare-summaries.ps1: adds the p99 row and free column labels, so it can compare
# pre-lab vs post-lab, Round Robin vs Least Connections, 1 vs 2 vs 3 instances, run 1 vs run 2 ...
#
# Usage (from repo root):
#   powershell -File high-load-systems/evidence/lab3/k6/compare-summaries.ps1 `
#       -Pre high-load-systems/evidence/lab3/k6/pre-lab/summary.json `
#       -Post high-load-systems/evidence/lab3/k6/post-lab/summary.json `
#       [-PreLabel 'Pre-lab'] [-PostLabel 'Post-lab']
#
# Change % = (post - pre) / pre * 100 (raw direction). Improvement % = the same number with the sign flipped for
# "lower is better" metrics (latency, errors), so positive always means better and negative always means worse.
# The summary files must have been produced with --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)".

param(
    [Parameter(Mandatory)] [string] $Pre,
    [Parameter(Mandatory)] [string] $Post,
    [string] $PreLabel = 'Pre-lab',
    [string] $PostLabel = 'Post-lab'
)

$a = (Get-Content $Pre -Raw | ConvertFrom-Json).metrics
$b = (Get-Content $Post -Raw | ConvertFrom-Json).metrics
$inv = [Globalization.CultureInfo]::InvariantCulture

# Sizes are always shown as "<GB>GB <MB>MB" (decimal units: 1 GB = 1000 MB), e.g. 2GB 567MB.
function Fmt($v, $unit) {
    switch ($unit) {
        'size'  { $gb = [math]::Floor($v / 1e9); $mb = [math]::Floor(($v % 1e9) / 1e6); return "${gb}GB ${mb}MB" }
        'ms'    { return ($v.ToString('0.0', $inv) + ' ms') }
        'req/s' { return ($v.ToString('0.00', $inv) + ' req/s') }
        default { return $v.ToString('0', $inv) }
    }
}

function Row($label, $metric, $field, $unit, $direction) {
    # $direction: 'lower' (lower is better), 'higher' (higher is better), 'info' (no verdict)
    $x = [double]$a.$metric.$field
    $y = [double]$b.$metric.$field
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

"| Metric | $PreLabel | $PostLabel | Change % | Improvement % | Verdict |"
"|---|---:|---:|---:|---:|---|"
Row 'Total requests'               'http_reqs'                 'count' ''      'higher'
Row 'Throughput'                   'http_reqs'                 'rate'  'req/s' 'higher'
Row 'Latency avg'                  'http_req_duration'         'avg'   'ms'    'lower'
Row 'Latency min'                  'http_req_duration'         'min'   'ms'    'lower'
Row 'Latency median'               'http_req_duration'         'med'   'ms'    'lower'
Row 'Latency p90'                  'http_req_duration'         'p(90)' 'ms'    'lower'
Row 'Latency p95'                  'http_req_duration'         'p(95)' 'ms'    'lower'
Row 'Latency p99'                  'http_req_duration'         'p(99)' 'ms'    'lower'
Row 'Latency max'                  'http_req_duration'         'max'   'ms'    'lower'
Row 'Server wait (TTFB) avg'       'http_req_waiting'          'avg'   'ms'    'lower'
Row 'Server wait (TTFB) p95'       'http_req_waiting'          'p(95)' 'ms'    'lower'
Row 'Iteration duration avg'       'iteration_duration'        'avg'   'ms'    'lower'
Row 'Iteration duration p95'       'iteration_duration'        'p(95)' 'ms'    'lower'
Row 'Failed requests'              'http_req_failed'           'passes' ''     'lower'
Row 'Data received'                'data_received'             'count' 'size'  'info'
