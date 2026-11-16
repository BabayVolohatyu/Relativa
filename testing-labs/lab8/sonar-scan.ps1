# Upload a fresh SonarQube analysis that includes both Graph and the root
# solution. Relativa.slnx does not build Graph, so a root-only build never
# publishes DashboardService or ResilientMlScoringClient.
# The token is read from the session and is not printed or persisted.
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrEmpty($env:SONAR_TOKEN)) {
    Write-Error "SONAR_TOKEN is not set in this session."
    exit 1
}

$sonarHost = "http://localhost:9000"
try {
    Invoke-WebRequest -Uri "$sonarHost/api/system/status" -UseBasicParsing -TimeoutSec 5 | Out-Null
} catch {
    Write-Error "SonarQube is not reachable at $sonarHost."
    exit 1
}

$repo = Split-Path -Parent $PSScriptRoot
Set-Location $repo

Write-Output "Starting SonarScanner for project Relativa."
dotnet sonarscanner begin `
    /k:"Relativa" `
    /d:sonar.host.url="$sonarHost" `
    /d:sonar.token="$env:SONAR_TOKEN" `
    /d:sonar.exclusions="Authentication/**,tests/e2e/**,Messaging/**" `
    /d:sonar.coverage.exclusions="ML/**"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Output "Building Graph/Relativa.Graph.sln"
dotnet build "Graph/Relativa.Graph.sln" --configuration Release
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Output "Building Relativa.slnx"
dotnet build "Relativa.slnx" --configuration Release
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Output "Uploading analysis."
dotnet sonarscanner end /d:sonar.token="$env:SONAR_TOKEN"
exit $LASTEXITCODE
