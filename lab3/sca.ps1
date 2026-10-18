# Repeatable NuGet vulnerability audit for the Graph solution.
# NuGet reports Moderate where the lab table says Medium; the summary maps that name.
param(
    [ValidateSet('before', 'after', 'ci')]
    [string]$Phase = 'before',
    [switch]$FailOnUnresolvedHigh
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$evidence = Join-Path $PSScriptRoot 'evidence'
New-Item -ItemType Directory -Force -Path $evidence | Out-Null
$solution = Join-Path $repo 'Graph/Relativa.Graph.sln'
$utf8 = [System.Text.UTF8Encoding]::new($false)

function Invoke-ListJson([string[]]$ExtraArgs) {
    $output = & dotnet list $solution package @ExtraArgs --include-transitive --format json
    if ($LASTEXITCODE -ne 0) {
        throw "dotnet list package failed with exit code $LASTEXITCODE"
    }
    return ($output | Out-String)
}

$vulnerableText = Invoke-ListJson @('--vulnerable')
$allText = Invoke-ListJson @()
$vulnerable = $vulnerableText | ConvertFrom-Json
$all = $allText | ConvertFrom-Json
$dotnetVersion = (& dotnet --version).Trim()

$packages = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$advisories = @()

function Add-Packages($doc, [bool]$onlyVulnerable) {
    foreach ($project in @($doc.projects)) {
        foreach ($framework in @($project.frameworks)) {
            foreach ($bucket in @('topLevelPackages', 'transitivePackages')) {
                foreach ($package in @($framework.$bucket)) {
                    if ($null -eq $package) { continue }
                    $version = $package.resolvedVersion
                    if ([string]::IsNullOrEmpty($version)) { $version = $package.requestedVersion }
                    [void]$packages.Add("$($package.id)|$version")
                    if (-not $onlyVulnerable) { continue }
                    foreach ($vuln in @($package.vulnerabilities)) {
                        if ($null -eq $vuln) { continue }
                        $script:advisories += [pscustomobject]@{
                            Project = $project.path
                            Package = $package.id
                            Version = $version
                            Direct = ($bucket -eq 'topLevelPackages')
                            Severity = $vuln.severity
                            AdvisoryUrl = $vuln.advisoryurl
                        }
                    }
                }
            }
        }
    }
}

Add-Packages $all $false
$componentCount = $packages.Count
$advisories = @()
Add-Packages $vulnerable $true

function Count-Severity([string]$name) {
    @($advisories | Where-Object { $_.Severity -eq $name } | Select-Object Package, Version, AdvisoryUrl -Unique).Count
}

$critical = Count-Severity 'Critical'
$high = Count-Severity 'High'
$moderate = Count-Severity 'Moderate'
$low = Count-Severity 'Low'

$jsonPath = Join-Path $evidence "sca-$Phase.json"
$summaryPath = Join-Path $evidence "sca-$Phase.txt"
[System.IO.File]::WriteAllText($jsonPath, $vulnerableText.Trim(), $utf8)

$lines = @(
    "tool=NuGet (dotnet list package --vulnerable)"
    "dotnet=$dotnetVersion"
    "command=dotnet list Graph/Relativa.Graph.sln package --vulnerable --include-transitive --format json"
    "files=Graph/**/*.csproj (solution Graph/Relativa.Graph.sln)"
    "components=$componentCount"
    "critical=$critical"
    "high=$high"
    "medium=$moderate"
    "low=$low"
    "note=NuGet severity Moderate is reported here as Medium."
)
foreach ($item in ($advisories | Sort-Object Severity, Package, AdvisoryUrl -Unique)) {
    $kind = if ($item.Direct) { 'direct' } else { 'transitive' }
    $lines += "advisory=$($item.Severity) $($item.Package) $($item.Version) $kind $($item.AdvisoryUrl)"
}
[System.IO.File]::WriteAllText($summaryPath, (($lines -join "`n") + "`n"), $utf8)
Write-Host "Wrote $summaryPath"
Get-Content $summaryPath

if ($FailOnUnresolvedHigh) {
    $acceptedPath = Join-Path $PSScriptRoot 'sca-accepted.md'
    $accepted = ''
    if (Test-Path $acceptedPath) { $accepted = Get-Content -Raw $acceptedPath }
    $unresolved = @($advisories | Where-Object { $_.Severity -in @('Critical', 'High') } | Where-Object {
        $id = if ($_.AdvisoryUrl -match '(GHSA-[\w-]+|CVE-[\d-]+)') { $Matches[1] } else { $_.AdvisoryUrl }
        $accepted -notlike "*$id*"
    } | Select-Object Package, Version, AdvisoryUrl -Unique)
    if ($unresolved.Count -gt 0) {
        Write-Error ("Unresolved High/Critical advisories:`n" + ($unresolved | Out-String))
        exit 1
    }
}
