# Shared helpers for the Lab 4 demo scripts (dot-source: . "$PSScriptRoot\common.ps1"). PowerShell 5.1, curl.exe, docker CLI.

$script:Lb        = 'http://localhost:8090'          # nginx graph-lb, Round Robin over graph-1/2/3
$script:Redis     = 'relativa-redis'
$script:KeyScan   = 'relativa-graph:graph:v1:*'      # every graph cache key (InstanceName prefix + key schema)
$script:RepoRoot  = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path

# One GET /api/v1/graph. Returns status, X-Cache (HIT/MISS/BYPASS/-), instance, milliseconds, node/edge counts, body bytes.
function Get-Graph {
    param([int] $OrgId = 1, [int] $UserId = 1, [string] $RiskLevel = '', [string] $Base = $script:Lb, [int] $TimeoutSec = 40)
    $url = "$Base/api/v1/graph?organizationId=$OrgId"
    if ($RiskLevel) { $url += "&riskLevel=$RiskLevel" }
    $hdr = Join-Path $env:TEMP 'lab4-headers.txt'
    $body = Join-Path $env:TEMP 'lab4-body.json'
    $t = & curl.exe -s -m $TimeoutSec -D $hdr -o $body -w '%{http_code} %{time_total} %{size_download}' -H "X-User-Id: $UserId" $url
    $p = $t -split ' '
    $h = if (Test-Path $hdr) { Get-Content $hdr } else { @() }
    $cache = ($h | Where-Object { $_ -match '^X-Cache:' } | Select-Object -First 1)
    $inst = ($h | Where-Object { $_ -match '^X-Instance-ID:' } | Select-Object -First 1)
    $nodes = $null; $edges = $null; $labels = @()
    if ($p[0] -eq '200') {
        $j = Get-Content $body -Raw | ConvertFrom-Json
        $nodes = @($j.nodes).Count; $edges = @($j.edges).Count; $labels = @($j.nodes | ForEach-Object { $_.label })
    }
    [pscustomobject]@{
        Status = [int]$p[0]
        XCache = if ($cache) { ($cache -replace '^X-Cache:\s*', '').Trim() } else { '-' }
        Instance = if ($inst) { ($inst -replace '^X-Instance-ID:\s*', '').Trim() } else { '-' }
        Ms = [math]::Round([double]::Parse($p[1], [Globalization.CultureInfo]::InvariantCulture) * 1000)
        Bytes = [int]$p[2]
        Nodes = $nodes; Edges = $edges; Labels = $labels
    }
}

function Format-Probe($label, $r) {
    '{0,-34} status={1} X-Cache={2,-6} served by {3,-8} {4,6} ms   nodes={5} edges={6} body={7} B' -f $label, $r.Status, $r.XCache, $r.Instance, $r.Ms, $r.Nodes, $r.Edges, $r.Bytes
}

# Keys currently in Redis, with remaining TTL in seconds (-2 = gone).
function Show-CacheKeys {
    param([string] $Title)
    "--- Redis keys ($Title)"
    $keys = @(docker exec $script:Redis redis-cli --scan --pattern $script:KeyScan 2>$null | Where-Object { $_ })
    if ($keys.Count -eq 0) { '    (none)'; return }
    foreach ($k in ($keys | Sort-Object)) {
        $ttl = docker exec $script:Redis redis-cli ttl $k
        '    {0}   TTL={1}s' -f $k, $ttl
    }
}

function Clear-CacheKeys {
    docker exec $script:Redis sh -c "redis-cli --scan --pattern '$script:KeyScan' | xargs -r redis-cli del" 2>&1 | Out-Null
}

# Waits until the URL answers 200.
function Wait-Graph {
    param([int] $TimeoutSec = 90)
    $sw = [Diagnostics.Stopwatch]::StartNew()
    while ($sw.Elapsed.TotalSeconds -lt $TimeoutSec) {
        if ((Get-Graph).Status -eq 200) { return $true }
        Start-Sleep -Seconds 2
    }
    return $false
}
