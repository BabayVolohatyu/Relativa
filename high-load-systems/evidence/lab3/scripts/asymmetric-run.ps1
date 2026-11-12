# Lab 3 - Asymmetric-load experiment: Round Robin vs Least Connections with one slow instance (graph-2, +500 ms).
#
# Prerequisite: the slow overlay is applied, i.e. graph-2 has ARTIFICIAL_DELAY_MS=500:
#   docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml `
#                  -f docker-compose.lab3-slow.yml up -d graph-2
#
# The same k6 scenario (50 VUs, 2 min) runs twice per algorithm, interleaved to spread machine drift evenly:
#   run 1: RR, LC      run 2: RR, LC
# Between runs nginx is switched LIVE (cp the other config + nginx -s reload). Files saved in k6/asymmetric/:
#   summary-rr.run1.json, summary-lc.run1.json, summary-rr.json, summary-lc.json (+ k6-output-*.txt)
# At the end nginx is back on Round Robin.
#
# Usage (from repo root):
#   powershell -File high-load-systems/evidence/lab3/scripts/asymmetric-run.ps1

. "$PSScriptRoot\common.ps1"
$dir = Join-Path $script:RepoRoot 'high-load-systems\evidence\lab3\k6\asymmetric'
$js = Join-Path $dir 'graph-load-test.js'

foreach ($run in 'run1', 'run2') {
    foreach ($alg in 'rr', 'lc') {
        $suffix = if ($run -eq 'run1') { ".run1" } else { "" }
        "=== $run / $alg ==="
        Set-LbAlgorithm $alg
        Start-Sleep -Seconds 3
        k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" `
            --summary-export (Join-Path $dir "summary-$alg$suffix.json") $js 2>&1 |
            Out-File -Encoding utf8 (Join-Path $dir "k6-output-$alg$suffix.txt")
        "finished $run / $alg"
        Start-Sleep -Seconds 10
    }
}
"=== back to Round Robin ==="
Set-LbAlgorithm rr
