# Measures Cognitive Complexity (S3776) and Cyclomatic Complexity (S1541)
# of WorkspaceDashboardService.GetSummaryAsync with SonarAnalyzer.CSharp.
# The threshold is forced to 1 so the warning still prints the value after it drops to <= 15.
param(
    [ValidateSet('before', 'after')]
    [string]$Phase = 'before'
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$project = Join-Path $repo 'Graph/src/Relativa.Graph/Relativa.Graph.csproj'
$source = Join-Path $repo 'Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs'
$evidence = Join-Path $PSScriptRoot 'evidence'
New-Item -ItemType Directory -Force -Path $evidence | Out-Null

$buildLog = Join-Path $evidence "complexity-$Phase.build.log"
$report = Join-Path $evidence "complexity-$Phase.txt"

Write-Host "Building with Lab3Complexity=true ($Phase)..."
$build = & dotnet build $project --configuration Release -p:Lab3Complexity=true -nodeReuse:false --nologo 2>&1
$build | Out-File -FilePath $buildLog -Encoding utf8
if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed. See $buildLog"
    exit $LASTEXITCODE
}

$text = Get-Content -Raw -Path $buildLog
$lines = Get-Content -Path $source

$methodStart = 0
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match 'Task<WorkspaceSummaryDto>\s+GetSummaryAsync\(') {
        $methodStart = $i + 1
        break
    }
}
if ($methodStart -eq 0) {
    Write-Error "GetSummaryAsync was not found in $source"
    exit 1
}

$depth = 0
$started = $false
$methodEnd = $methodStart
for ($i = $methodStart - 1; $i -lt $lines.Count; $i++) {
    foreach ($ch in $lines[$i].ToCharArray()) {
        if ($ch -eq '{') { $depth++; $started = $true }
        elseif ($ch -eq '}') { $depth-- }
    }
    if ($started -and $depth -eq 0) {
        $methodEnd = $i + 1
        break
    }
}
$lineCount = $methodEnd - $methodStart + 1

function Get-Metric([string]$ruleId, [string]$pattern) {
    $hits = [regex]::Matches($text, "WorkspaceDashboardService\.cs\((\d+),\d+\): warning $ruleId.*")
    foreach ($hit in $hits) {
        $line = [int]$hit.Groups[1].Value
        if ($line -ge $methodStart -and $line -le $methodEnd) {
            $value = [regex]::Match($hit.Value, $pattern)
            if ($value.Success) {
                return [pscustomobject]@{
                    Value = [int]$value.Groups[1].Value
                    Threshold = [int]$value.Groups[2].Value
                }
            }
        }
    }
    return $null
}

$cognitivePair = Get-Metric 'S3776' 'Cognitive Complexity from (\d+) to the (\d+) allowed'
$cyclomaticPair = Get-Metric 'S1541' 'Cyclomatic Complexity (?:of this method is|from) (\d+) which is greater than (\d+) authorized'

if ($null -eq $cognitivePair -or $null -eq $cyclomaticPair) {
    Write-Error "Could not read both metrics for GetSummaryAsync. See $buildLog"
    exit 1
}

$cognitive = $cognitivePair.Value
$cognitiveThreshold = $cognitivePair.Threshold
$cyclomatic = $cyclomaticPair.Value
$cyclomaticThreshold = $cyclomaticPair.Threshold

if ($cognitiveThreshold -ne 1 -or $cyclomaticThreshold -ne 1) {
    Write-Error "Rule thresholds were cognitive=$cognitiveThreshold cyclomatic=$cyclomaticThreshold, expected 1. See $buildLog"
    exit 1
}

$analyzer = 'SonarAnalyzer.CSharp'
$versionLine = Select-String -Path $project -Pattern 'SonarAnalyzer\.CSharp" Version="([^"]+)"' | Select-Object -First 1
$analyzerVersion = if ($versionLine) { $versionLine.Matches[0].Groups[1].Value } else { 'unknown' }
$dotnetVersion = (& dotnet --version).Trim()

@(
    "method=WorkspaceDashboardService.GetSummaryAsync"
    "file=Graph/src/Relativa.Graph/Dashboard/WorkspaceDashboardService.cs"
    "lines=$methodStart-$methodEnd"
    "line_count=$lineCount"
    "cognitive_complexity=$cognitive"
    "cyclomatic_complexity=$cyclomatic"
    "analyzer=$analyzer $analyzerVersion"
    "rules=S3776 threshold=$cognitiveThreshold; S1541 threshold=$cyclomaticThreshold"
    "dotnet=$dotnetVersion"
    "command=dotnet build Graph/src/Relativa.Graph/Relativa.Graph.csproj --configuration Release -p:Lab3Complexity=true"
) | Set-Content -Path $report -Encoding utf8

Write-Host "Wrote $report"
Get-Content $report
