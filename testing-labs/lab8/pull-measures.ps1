# Read CK/MOOD-shaped measures from a local SonarQube. Auth stays in the
# session environment. This script never prints SONAR_TOKEN and never writes
# it to the user profile.
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
$evidence = Join-Path $repo "lab8\evidence"
New-Item -ItemType Directory -Force -Path $evidence | Out-Null

$basic = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($env:SONAR_TOKEN):"))
$headers = @{ Authorization = "Basic $basic" }

function Invoke-SonarGet {
    param([string]$Url)
    try {
        $response = Invoke-WebRequest -Uri $Url -Headers $headers -Method Get -UseBasicParsing
        return @{ Status = [int]$response.StatusCode; Body = [string]$response.Content }
    } catch [System.Net.WebException] {
        $web = $_.Exception.Response
        if ($null -eq $web) { throw }
        $reader = New-Object System.IO.StreamReader($web.GetResponseStream())
        $body = $reader.ReadToEnd()
        $reader.Dispose()
        return @{ Status = [int]$web.StatusCode; Body = $body }
    }
}

function Write-Utf8 {
    param([string]$Path, [string]$Text)
    $utf8 = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($Path, $Text, $utf8)
}

$designKeys = "class_complexity,coupling_between_objects,lcom4,dit,rfc,cohesion_in_methods,complexity,cognitive_complexity"
$supportedFileKeys = "ncloc,complexity,cognitive_complexity,functions,classes"
$projectDesignKeys = "$designKeys,ncloc,classes,functions"
$projectSupportedKeys = "ncloc,complexity,cognitive_complexity,classes,functions"

$targets = @(
    @{ Name = "domain"; Path = "Graph/src/Relativa.Graph/Dashboard/DashboardService.cs"; Query = "DashboardService.cs" },
    @{ Name = "infra"; Path = "Graph/src/Relativa.Graph/ML/ResilientMlScoringClient.cs"; Query = "ResilientMlScoringClient.cs" },
    @{ Name = "utility"; Path = "Core/src/Relativa.Core.Application/Validators/CreateEntityRequestValidator.cs"; Query = "CreateEntityRequestValidator.cs" }
)

$requestLog = New-Object System.Collections.Generic.List[string]
$missing = $false

foreach ($target in $targets) {
    $query = [Uri]::EscapeDataString($target.Query)
    $searchUrl = "$sonarHost/api/components/tree?component=Relativa&q=$query&ps=50"
    $requestLog.Add("GET $searchUrl")
    $search = Invoke-SonarGet $searchUrl
    $searchPath = Join-Path $evidence ("api-search-" + $target.Name + ".json")
    Write-Utf8 $searchPath $search.Body

    $parsed = $search.Body | ConvertFrom-Json
    $match = $null
    if ($parsed.components) {
        $match = $parsed.components | Where-Object { $_.path -eq $target.Path } | Select-Object -First 1
    }
    if ($null -eq $match) {
        Write-Error "No Sonar component for $($target.Path). Run lab8/sonar-scan.ps1, then pull again."
        $missing = $true
        continue
    }

    $key = [Uri]::EscapeDataString($match.key)
    $designUrl = "$sonarHost/api/measures/component?component=$key&metricKeys=$designKeys"
    $requestLog.Add("GET $designUrl")
    $design = Invoke-SonarGet $designUrl
    Write-Utf8 (Join-Path $evidence ("api-" + $target.Name + ".json")) $design.Body

    $supportedUrl = "$sonarHost/api/measures/component?component=$key&metricKeys=$supportedFileKeys"
    $requestLog.Add("GET $supportedUrl")
    $supported = Invoke-SonarGet $supportedUrl
    Write-Utf8 (Join-Path $evidence ("api-" + $target.Name + "-supported.json")) $supported.Body
}

$projectDesignUrl = "$sonarHost/api/measures/component?component=Relativa&metricKeys=$projectDesignKeys"
$requestLog.Add("GET $projectDesignUrl")
$projectDesign = Invoke-SonarGet $projectDesignUrl
Write-Utf8 (Join-Path $evidence "api-project.json") $projectDesign.Body

$projectSupportedUrl = "$sonarHost/api/measures/component?component=Relativa&metricKeys=$projectSupportedKeys"
$requestLog.Add("GET $projectSupportedUrl")
$projectSupported = Invoke-SonarGet $projectSupportedUrl
Write-Utf8 (Join-Path $evidence "api-project-supported.json") $projectSupported.Body

Write-Utf8 (Join-Path $evidence "api-requests.txt") (($requestLog -join "`n") + "`n")

if ($missing) { exit 2 }
Write-Output "Saved Sonar responses under lab8/evidence"
exit 0
