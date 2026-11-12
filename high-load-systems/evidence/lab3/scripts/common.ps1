# Shared helpers for the Lab 3 demo scripts (dot-source this file: . "$PSScriptRoot\common.ps1").
# PowerShell 5.1 compatible. Needs curl.exe >= 7.84 (Windows 10 ships a newer one) and the docker CLI.

$script:Lb      = 'http://localhost:8090'   # the single entry point (nginx graph-lb)
$script:LbName  = 'relativa-graph-lb'
$script:GraphUrl = '/api/v1/graph?organizationId=1'
$script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path

# One request. Returns Status (0 = connection failed), Instance (X-Instance-ID), Ms.
function Get-Probe {
    param([string] $Url, [switch] $Graph)
    $args2 = @('-s', '-o', 'NUL', '-m', '30', '-w', '%{http_code} %header{x-instance-id} %{time_total}')
    if ($Graph) { $args2 += @('-H', 'X-User-Id: 1') }
    $out = (& curl.exe @args2 $Url) -split ' '
    [pscustomobject]@{
        Status   = [int]$out[0]
        Instance = if ($out.Count -ge 3) { $out[1] } else { '' }
        Ms       = [math]::Round([double]::Parse($out[$out.Count - 1], [Globalization.CultureInfo]::InvariantCulture) * 1000)
    }
}

# N requests with `Concurrency` in flight at the same time (curl --parallel). Returns one object per request.
function Get-ParallelProbes {
    param([string] $Url, [int] $Count = 60, [int] $Concurrency = 12)
    $targets = 1..$Count | ForEach-Object { '-o'; 'NUL'; $Url }   # one "-o NUL <url>" pair per request
    $raw = & curl.exe -s -Z --parallel-max $Concurrency -m 60 -H 'X-User-Id: 1' `
        -w '%{http_code} %header{x-instance-id} %{time_total}\n' @targets
    $raw | Where-Object { $_ } | ForEach-Object {
        $p = $_ -split ' '
        [pscustomobject]@{
            Status   = [int]$p[0]
            Instance = if ($p.Count -ge 3) { $p[1] } else { '' }
            Ms       = [math]::Round([double]::Parse($p[$p.Count - 1], [Globalization.CultureInfo]::InvariantCulture) * 1000)
        }
    }
}

# Prints the distribution per instance and the latency percentiles of a set of probes.
function Show-Distribution {
    param($Probes, [string] $Title)
    $total = @($Probes).Count
    "--- $Title ($total requests)"
    $Probes | Group-Object Instance | Sort-Object Name | ForEach-Object {
        '{0,-10} {1,4} requests  {2,5:N1}%' -f $(if ($_.Name) { $_.Name } else { '(none)' }), $_.Count, ($_.Count * 100.0 / $total)
    }
    $bad = @($Probes | Where-Object { $_.Status -ne 200 }).Count
    $ms = @($Probes | Sort-Object Ms | ForEach-Object { $_.Ms })
    $p = { param($q) $ms[[math]::Min($ms.Count - 1, [math]::Ceiling($q * $ms.Count) - 1)] }
    'non-200 responses: {0}   latency ms: min={1} median={2} p95={3} p99={4} max={5}' -f $bad, $ms[0], (& $p 0.5), (& $p 0.95), (& $p 0.99), $ms[-1]
}

# Switch the live nginx to one of the config files in infra/nginx and reload it without dropping connections.
function Set-LbAlgorithm {
    param([ValidateSet('rr', 'lc')] [string] $Algorithm)
    # Both config files are mounted read-only under /etc/nginx/lab3/ (docker-compose.lab3.yml); the active path is a plain file.
    docker exec $script:LbName sh -c "cp /etc/nginx/lab3/$Algorithm.conf /etc/nginx/conf.d/default.conf" | Out-Null
    $ErrorActionPreference = 'Continue'
    (docker exec $script:LbName nginx -t 2>&1) | ForEach-Object { "   nginx -t: $_" }
    (docker exec $script:LbName nginx -s reload 2>&1) | Out-Null
    Start-Sleep -Seconds 1
    "   nginx now runs: $(if ($Algorithm -eq 'rr') { 'ROUND ROBIN' } else { 'LEAST CONNECTIONS' })"
}

# Waits until the given URL answers 200 (or gives up after $TimeoutSec).
function Wait-Http {
    param([string] $Url, [int] $TimeoutSec = 90)
    $sw = [Diagnostics.Stopwatch]::StartNew()
    while ($sw.Elapsed.TotalSeconds -lt $TimeoutSec) {
        if ((Get-Probe $Url).Status -eq 200) { return $true }
        Start-Sleep -Seconds 2
    }
    return $false
}
