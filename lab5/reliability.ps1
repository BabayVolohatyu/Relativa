# Reliability of Lizard 1.24.3 on WorkspaceDashboardService.cs.
# Scenario A: CRLF vs LF, same pinned analyzer image.
# Scenario B: same LF bytes and same Lizard pin, Python 3.11 vs Python 3.14.
# Continue: Windows PowerShell 5.1 turns native stderr (pip warnings, docker progress) into terminating errors when Stop is set.
$ErrorActionPreference = 'Continue'
if (Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue) {
    $PSNativeCommandUseErrorActionPreference = $false
}

$lab = $PSScriptRoot
$repo = Split-Path $lab -Parent
$source = Join-Path $repo 'Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs'
$evidence = Join-Path $lab 'evidence/reliability'
$fixtures = Join-Path $evidence 'fixtures'
$image = 'relativa-lab5-analyzer:1.24.3'
$pythonLts = 'python:3.11-slim@sha256:b7a9e5f6a93d6d4a31f129bbd4bdee69efccb6ded0fb230d78aafaf37af98377'
$pythonCurrent = 'python:3.14-slim@sha256:35caba83af2fe6da9a5d922f9b0156f21d1246a48278c58a08bd253303ba42e8'

New-Item -ItemType Directory -Force -Path $fixtures | Out-Null

function Write-NormalizedCopies {
    $text = [IO.File]::ReadAllText($source)
    $lf = $text -replace "`r`n", "`n" -replace "`r", "`n"
    $crlf = $lf -replace "`n", "`r`n"
    $utf8 = New-Object System.Text.UTF8Encoding $false
    $lfPath = Join-Path $fixtures 'WorkspaceDashboardService.lf.cs'
    $crlfPath = Join-Path $fixtures 'WorkspaceDashboardService.crlf.cs'
    [IO.File]::WriteAllText($lfPath, $lf, $utf8)
    [IO.File]::WriteAllText($crlfPath, $crlf, $utf8)

    $lfBytes = [IO.File]::ReadAllBytes($lfPath)
    $crlfBytes = [IO.File]::ReadAllBytes($crlfPath)
    $lfCrlf = 0
    $crlfCrlf = 0
    for ($i = 0; $i -lt $lfBytes.Length - 1; $i++) {
        if ($lfBytes[$i] -eq 13 -and $lfBytes[$i + 1] -eq 10) { $lfCrlf++ }
    }
    for ($i = 0; $i -lt $crlfBytes.Length - 1; $i++) {
        if ($crlfBytes[$i] -eq 13 -and $crlfBytes[$i + 1] -eq 10) { $crlfCrlf++ }
    }
    if ($lfCrlf -ne 0) { throw "LF fixture still contains CRLF pairs: $lfCrlf" }
    if ($crlfCrlf -lt 10) { throw "CRLF fixture did not gain CRLF pairs: $crlfCrlf" }
    "lf_crlf_pairs=$lfCrlf crlf_pairs=$crlfCrlf lf_bytes=$($lfBytes.Length) crlf_bytes=$($crlfBytes.Length)" |
        Set-Content -Path (Join-Path $evidence 'line-endings.txt') -Encoding utf8
}

function Get-LizardSummary([string]$logPath) {
    $rows = @()
    $inTable = $false
    foreach ($line in (Get-Content -Path $logPath)) {
        if ($line -match 'NLOC\s+CCN\s+token') { $inTable = $true; continue }
        if (-not $inTable) { continue }
        if ($line -match '^-+' -or $line -match '^=+') { continue }
        if ($line -match '^\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+\S') {
            $rows += [pscustomobject]@{
                Nloc = [int]$Matches[1]
                Ccn = [int]$Matches[2]
                Tokens = [int]$Matches[3]
            }
            continue
        }
        if ($rows.Count -gt 0) { break }
    }
    if ($rows.Count -lt 1) { throw "Could not parse Lizard table in $logPath" }
    $fileNloc = $null
    foreach ($line in (Get-Content -Path $logPath)) {
        if ($line -match '^\s+(\d+)\s+\d+\.\d+\s+\d+\.\d+\s+\d+\.\d+\s+(\d+)\s+\S') {
            $fileNloc = [int]$Matches[1]
            break
        }
    }
    if ($null -eq $fileNloc) { throw "Could not parse Lizard file summary in $logPath" }
    $ccn = $rows | ForEach-Object { $_.Ccn } | Sort-Object
    $mid = [math]::Floor($ccn.Count / 2)
    if ($ccn.Count % 2 -eq 1) { $median = $ccn[$mid] } else { $median = ($ccn[$mid - 1] + $ccn[$mid]) / 2.0 }
    $ccnSum = 0
    $tokenSum = 0
    foreach ($row in $rows) { $ccnSum += $row.Ccn; $tokenSum += $row.Tokens }
    [pscustomobject]@{
        Functions = $rows.Count
        Nloc = $fileNloc
        CcnTotal = $ccnSum
        CcnMax = ($rows | Measure-Object Ccn -Maximum).Maximum
        CcnMedian = $median
        Tokens = $tokenSum
    }
}

function Invoke-Logged([string]$logName, [scriptblock]$command) {
    $log = Join-Path $evidence $logName
    & $command *>&1 | Out-File -FilePath $log -Encoding utf8
    if ($LASTEXITCODE -ne 0) {
        throw "Command for $logName failed with exit $LASTEXITCODE. See $log"
    }
    return $log
}

Write-NormalizedCopies

Write-Host 'Building pinned analyzer image...'
docker build -t $image -f (Join-Path $lab 'Dockerfile.analyzer') $lab
if ($LASTEXITCODE -ne 0) { throw "docker build failed with exit $LASTEXITCODE" }

Invoke-Logged 'scenario-a-lf.txt' {
    docker run --rm --cpus=1 --memory=512m --entrypoint sh -v "${fixtures}:/scan:ro" $image -c "python --version && lizard --version && lizard -C 9999 -L 99999 /scan/WorkspaceDashboardService.lf.cs"
} | Out-Null

Invoke-Logged 'scenario-a-crlf.txt' {
    docker run --rm --cpus=1 --memory=512m --entrypoint sh -v "${fixtures}:/scan:ro" $image -c "python --version && lizard --version && lizard -C 9999 -L 99999 /scan/WorkspaceDashboardService.crlf.cs"
} | Out-Null

$install = 'python --version && pip install --disable-pip-version-check --no-cache-dir lizard==1.24.3 && lizard --version && lizard -C 9999 -L 99999 /scan/WorkspaceDashboardService.lf.cs'

Invoke-Logged 'scenario-b-py311.txt' {
    docker run --rm --cpus=1 --memory=512m -v "${fixtures}:/scan:ro" $pythonLts sh -c $install
} | Out-Null

Invoke-Logged 'scenario-b-py314.txt' {
    docker run --rm --cpus=1 --memory=512m -v "${fixtures}:/scan:ro" $pythonCurrent sh -c $install
} | Out-Null

$aLf = Get-LizardSummary (Join-Path $evidence 'scenario-a-lf.txt')
$aCr = Get-LizardSummary (Join-Path $evidence 'scenario-a-crlf.txt')
$b311 = Get-LizardSummary (Join-Path $evidence 'scenario-b-py311.txt')
$b314 = Get-LizardSummary (Join-Path $evidence 'scenario-b-py314.txt')

$rows = @(
    "run,functions,nloc,ccn_total,ccn_max,ccn_median,tokens"
    "scenario-a-lf,$($aLf.Functions),$($aLf.Nloc),$($aLf.CcnTotal),$($aLf.CcnMax),$($aLf.CcnMedian),$($aLf.Tokens)"
    "scenario-a-crlf,$($aCr.Functions),$($aCr.Nloc),$($aCr.CcnTotal),$($aCr.CcnMax),$($aCr.CcnMedian),$($aCr.Tokens)"
    "scenario-b-py311,$($b311.Functions),$($b311.Nloc),$($b311.CcnTotal),$($b311.CcnMax),$($b311.CcnMedian),$($b311.Tokens)"
    "scenario-b-py314,$($b314.Functions),$($b314.Nloc),$($b314.CcnTotal),$($b314.CcnMax),$($b314.CcnMedian),$($b314.Tokens)"
)
$rows | Set-Content -Path (Join-Path $evidence 'summary.csv') -Encoding utf8
$rows | Write-Host

Remove-Item -Recurse -Force $fixtures
Write-Host 'Reliability evidence written.'
