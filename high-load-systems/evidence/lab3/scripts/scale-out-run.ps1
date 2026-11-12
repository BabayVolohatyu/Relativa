# Lab 3 - Scale-out experiment: 1, 2 and 3 Graph instances behind the same nginx, same saturating k6 load.
#
# Needs the CPU-limited stack (1 core per Graph instance):
#   docker compose -f docker-compose.yaml -f docker-compose.lab2.yml -f docker-compose.lab3.yml `
#                  -f docker-compose.lab3-cpulimit.yml up -d
# For each N in 1,2,3 the script
#   1. writes an nginx config with only the first N servers (derived from graph-lb-lab3-rr.conf, so there is one source),
#      copies it into the running nginx and reloads it (all three containers keep running, the idle ones use no CPU),
#   2. runs k6 (graph-scale-test.js) and saves summary + console output,
#   3. samples `docker stats` every 5 s during the run (CPU of Graph instances, postgres, ml, rabbitmq, redis, nginx)
#      to see which component saturates first.
# At the end nginx is restored to the 3-server round-robin config.
#
# Usage (from repo root):
#   powershell -File high-load-systems/evidence/lab3/scripts/scale-out-run.ps1 [-Suffix ''] [-Vus 120]
#   (use -Suffix .run1 to keep a second run next to the first)

param(
    [string] $Suffix = '',
    [int] $Vus = 120,
    [string] $Hold = '50s'
)

. "$PSScriptRoot\common.ps1"
$outDir = Join-Path $script:RepoRoot 'high-load-systems\evidence\lab3\k6\scale-out'
$script_ = Join-Path $outDir 'graph-scale-test.js'
$rrConf = Join-Path $script:RepoRoot 'infra\nginx\graph-lb-lab3-rr.conf'

function Set-ServerCount([int] $n) {
    $script:seen = 0
    $lines = Get-Content $rrConf | Where-Object {
        if ($_ -match '^\s*server graph(-\d)?:8083') { $script:seen++; $script:seen -le $n } else { $true }
    }
    $tmp = Join-Path $env:TEMP "graph-lb-scale-$n.conf"
    Set-Content -Path $tmp -Value $lines -Encoding ascii
    docker cp $tmp "$($script:LbName):/etc/nginx/conf.d/default.conf" | Out-Null
    docker exec $script:LbName nginx -t 2>&1 | Out-Null
    docker exec $script:LbName nginx -s reload | Out-Null
    Start-Sleep -Seconds 2
    "nginx upstream now has $n server(s)"
}

foreach ($n in 1, 2, 3) {
    ""
    "=== $n instance(s) ==="
    Set-ServerCount $n
    # warm-up: a few requests so JIT / connection pools are not part of the measurement
    1..6 | ForEach-Object { Get-Probe "$script:Lb$script:GraphUrl" -Graph | Out-Null }

    $statsFile = Join-Path $outDir "docker-stats-$n-instances$Suffix.txt"
    $sampler = Start-Job -ArgumentList $statsFile -ScriptBlock {
        param($f)
        Remove-Item $f -ErrorAction SilentlyContinue
        1..16 | ForEach-Object {
            Start-Sleep -Seconds 5
            "# t=$($_ * 5)s" | Out-File -Append -Encoding utf8 $f
            docker stats --no-stream --format '{{.Name}}  cpu={{.CPUPerc}}  mem={{.MemUsage}}' |
                Where-Object { $_ -match 'graph|postgres|ml|rabbitmq|redis' } | Sort-Object | Out-File -Append -Encoding utf8 $f
        }
    }
    $env:VUS = "$Vus"; $env:HOLD = $Hold
    k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" `
        --summary-export (Join-Path $outDir "summary-$n-instances$Suffix.json") $script_ 2>&1 |
        Out-File -Encoding utf8 (Join-Path $outDir "k6-output-$n-instances$Suffix.txt")
    $sampler | Wait-Job -Timeout 30 | Out-Null
    $sampler | Remove-Job -Force
    "k6 finished for $n instance(s); summary-$n-instances$Suffix.json saved"
    Start-Sleep -Seconds 15   # let the queues (ML RPC backlog) drain before the next run
}

""
"=== restoring nginx to the 3-server round-robin config ==="
Set-ServerCount 3
