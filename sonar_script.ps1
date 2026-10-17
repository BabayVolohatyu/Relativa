# ==============================================================================
# Configuration
# ==============================================================================
$SONAR_HOST  = "http://localhost:9000"
$PROJECT_KEY = "Relativa"

# 1. Check and save token globally for the user (User Environment Variable)
if ([string]::IsNullOrEmpty($env:SONAR_TOKEN)) {
    Write-Error "Error: `$env:SONAR_TOKEN is not set in the current session!"
    Write-Host "Set it temporarily via: `$env:SONAR_TOKEN='your_token' and re-run the script." -ForegroundColor Yellow
    exit 1
} else {
    # Save token globally for the user (similar to setx)
    [System.Environment]::SetEnvironmentVariable("SONAR_TOKEN", $env:SONAR_TOKEN, "User")
    Write-Host "===> SONAR_TOKEN successfully saved to user environment variables." -ForegroundColor Cyan
}

$SONAR_TOKEN =$env:SONAR_TOKEN

# 2. Start SonarScanner analysis
Write-Host "===> 2. Starting SonarScanner..." -ForegroundColor Green
dotnet sonarscanner begin `
  /k:"$PROJECT_KEY" `
  /d:sonar.host.url="$SONAR_HOST" `
  /d:sonar.token="$SONAR_TOKEN" `
  /d:sonar.cs.opencover.reportsPaths="**/TestResults/**/coverage.opencover.xml" `
  /d:sonar.exclusions="Authentication/**,tests/e2e/**,Messaging/**" `
  /d:sonar.coverage.exclusions="ML/**"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to start SonarScanner."
    exit $LASTEXITCODE
}

# 3. Build the project
Write-Host "===> 3. Building project (Release)..." -ForegroundColor Green
dotnet build --configuration Release

if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed."
    exit $LASTEXITCODE
}

# 4. Run tests and collect coverage
Write-Host "===> 4. Running tests and collecting code coverage (OpenCover)..." -ForegroundColor Green
dotnet test --configuration Release `
  --no-build `
  --collect:"XPlat Code Coverage" `
  -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=opencover

if ($LASTEXITCODE -ne 0) {
    Write-Warning "Some tests failed, but analysis report will still be submitted to SonarQube."
}

# 5. End SonarScanner analysis and upload results
Write-Host "===> 5. Ending SonarScanner analysis and sending results..." -ForegroundColor Green
dotnet sonarscanner end /d:sonar.token="$SONAR_TOKEN"

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nSuccess! Analysis results uploaded to $SONAR_HOST/dashboard?id=$PROJECT_KEY" -ForegroundColor Cyan
} else {
    Write-Error "Failed to end SonarScanner analysis."
}