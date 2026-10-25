# Balanced quality gate: line coverage AND mutation score.
# Messaging coverage is the Relativa.Messaging assembly (full suite).
# Mutation score is Stryker on RabbitMqExchangeRouter only, so each mutant
# does not start the RabbitMQ testcontainer.
param(
    [ValidateSet('messaging', 'fixture')]
    [string]$Target = 'messaging'
)

# Continue: Windows PowerShell 5.1 turns native stderr into a terminating error when Stop is set.
$ErrorActionPreference = 'Continue'
if (Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue) {
    $PSNativeCommandUseErrorActionPreference = $false
}

$lab = $PSScriptRoot
$repo = Split-Path $lab -Parent
$thresholds = Get-Content -Raw -Path (Join-Path $lab 'quality-gate.json') | ConvertFrom-Json
$minLine = [double]$thresholds.minLineCoveragePercent
$minMutation = [double]$thresholds.minMutationScorePercent
$evidence = Join-Path $lab "evidence/quality-gate/$Target"
New-Item -ItemType Directory -Force -Path $evidence | Out-Null

function Get-NewestCobertura([string]$directory) {
    $file = Get-ChildItem -Path $directory -Recurse -Filter coverage.cobertura.xml |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1
    if ($null -eq $file) {
        throw "No coverage.cobertura.xml under $directory"
    }
    return $file.FullName
}

function Get-LineCoveragePercent([string]$coberturaPath) {
    [xml]$doc = Get-Content -Raw -Path $coberturaPath
    return [math]::Round(([double]$doc.coverage.'line-rate') * 100, 2)
}

function Get-MutationScorePercent([string]$logPath, [string]$outputDir) {
    $text = ''
    if (Test-Path $logPath) {
        $text = Get-Content -Raw -Path $logPath
    }
    $match = [regex]::Match($text, 'mutation score is\s+([0-9]+(?:[.,][0-9]+)?)')
    if ($match.Success) {
        return [double]($match.Groups[1].Value.Replace(',', '.'))
    }

    $json = Get-ChildItem -Path $outputDir -Recurse -Filter mutation-report.json -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1
    if ($null -eq $json) {
        throw "Mutation score not found in $logPath or under $outputDir"
    }

    $report = Get-Content -Raw -Path $json.FullName | ConvertFrom-Json
    $counts = @{}
    foreach ($file in $report.files.PSObject.Properties) {
        foreach ($mutant in @($file.Value.mutants)) {
            $status = [string]$mutant.status
            if (-not $counts.ContainsKey($status)) { $counts[$status] = 0 }
            $counts[$status]++
        }
    }
    $killed = 0
    if ($counts.ContainsKey('Killed')) { $killed = $counts['Killed'] }
    $denominator = 0
    foreach ($status in @('Killed', 'Survived', 'Timeout')) {
        if ($counts.ContainsKey($status)) { $denominator += $counts[$status] }
    }
    if ($denominator -eq 0) {
        throw "Mutation report has no killed, survived, or timeout mutants."
    }
    return [math]::Round(100.0 * $killed / $denominator, 2)
}

Push-Location $repo
try {
    dotnet tool restore | Out-Host
    if ($LASTEXITCODE -ne 0) { throw "dotnet tool restore failed with exit $LASTEXITCODE" }

    $coverageDir = Join-Path $evidence 'coverage'
    New-Item -ItemType Directory -Force -Path $coverageDir | Out-Null

    if ($Target -eq 'messaging') {
        $testProject = 'Messaging/tests/Relativa.Messaging.Tests/Relativa.Messaging.Tests.csproj'
        $settings = 'ci/coverage/messaging.runsettings'
        $config = 'lab5/stryker.messaging.json'
    }
    else {
        $testProject = 'lab5/goodhart/CoverageTrap.Tests/CoverageTrap.Tests.csproj'
        $settings = 'lab5/goodhart/coverlet.runsettings'
        $config = 'lab5/stryker.fixture.json'
    }

    Write-Host "Coverage: $testProject"
    dotnet test $testProject --configuration Release --collect:"XPlat Code Coverage" --settings $settings --results-directory $coverageDir --verbosity minimal --nologo
    if ($LASTEXITCODE -ne 0) { throw "dotnet test failed with exit $LASTEXITCODE" }
    $line = Get-LineCoveragePercent (Get-NewestCobertura $coverageDir)
    Write-Host "Line coverage: $line%"

    $strykerOut = Join-Path $evidence 'stryker'
    if (Test-Path $strykerOut) { Remove-Item -Recurse -Force $strykerOut }
    $strykerLog = Join-Path $evidence 'stryker.log'
    Write-Host "Stryker: $config"
    # Stryker 5 looks for binaries under bin\Any CPU\Release. SDK projects omit the platform folder unless this is set.
    $env:LAB5_STRYKER = 'true'
    dotnet stryker --config-file $config --configuration Release --concurrency 2 --break-at 0 --reporter cleartext --reporter json --output $strykerOut --skip-version-check > $strykerLog 2>&1
    $strykerExit = $LASTEXITCODE
    Get-Content -Path $strykerLog | Write-Host
    if ($strykerExit -ne 0) {
        throw "Stryker exited with code $strykerExit. See $strykerLog"
    }

    $mutation = Get-MutationScorePercent $strykerLog $strykerOut
    Write-Host "Mutation score: $mutation%"

    $coveragePass = $line -ge $minLine
    $mutationPass = $mutation -ge $minMutation
    $pass = $coveragePass -and $mutationPass
    $verdict = if ($pass) { 'PASS' } else { 'FAIL' }
    $formula = "(line coverage >= $minLine%) AND (mutation score >= $minMutation%)"
    $report = @(
        "target=$Target"
        "line_coverage_percent=$line"
        "mutation_score_percent=$mutation"
        "min_line_coverage_percent=$minLine"
        "min_mutation_score_percent=$minMutation"
        "coverage_pass=$coveragePass"
        "mutation_pass=$mutationPass"
        "verdict=$verdict"
        "formula=$formula"
    )
    $verdictPath = Join-Path $evidence 'verdict.txt'
    $report | Set-Content -Path $verdictPath -Encoding utf8
    Write-Host ($report -join "`n")

    if (-not $pass) { throw "Quality gate FAIL for $Target. formula=$formula" }
}
finally {
    Remove-Item Env:LAB5_STRYKER -ErrorAction SilentlyContinue
    Pop-Location
}
