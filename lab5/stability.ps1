# Stability of the lab 2 graph-read SLO under a CPU cap on relativa-graph.
# Thresholds stay in lab2/k6/graph-read.js (p95 < 2700 ms, error rate < 1%).
# Continue: Windows PowerShell 5.1 turns native stderr into a terminating error when Stop is set.
$ErrorActionPreference = 'Continue'
if (Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue) {
    $PSNativeCommandUseErrorActionPreference = $false
}

$lab = $PSScriptRoot
$repo = Split-Path $lab -Parent
$evidence = Join-Path $lab 'evidence/stability'
$k6Image = 'grafana/k6:2.2.0'
$container = 'relativa-graph'
New-Item -ItemType Directory -Force -Path $evidence | Out-Null

$sha = (git -C $repo rev-parse HEAD).Trim()
$imageId = (docker inspect $container --format '{{.Image}}').Trim()
$originalNano = [int64](docker inspect $container --format '{{.HostConfig.NanoCpus}}').Trim()

function Wait-Graph {
    for ($i = 0; $i -lt 30; $i++) {
        try {
            Invoke-WebRequest -Uri http://localhost:8083/ -UseBasicParsing -TimeoutSec 5 | Out-Null
            return
        }
        catch {
            $response = $_.Exception.Response
            if ($null -ne $response) {
                $status = [int]$response.StatusCode
                if ($status -ge 400 -and $status -lt 500) { return }
            }
            Start-Sleep -Seconds 2
        }
    }
    throw 'Graph did not accept HTTP on port 8083.'
}

function Restore-GraphCpu {
    $current = [int64](docker inspect $container --format '{{.HostConfig.NanoCpus}}').Trim()
    if ($current -eq $originalNano) { return }
    Push-Location $repo
    try {
        if ($originalNano -eq 0) {
            # docker update --cpus=0 leaves the previous NanoCpus value in place.
            docker compose up -d --no-deps --no-build --force-recreate graph
        }
        else {
            $cpus = ($originalNano / 1000000000).ToString([cultureinfo]::InvariantCulture)
            docker update --cpus=$cpus $container | Out-Null
        }
        if ($LASTEXITCODE -ne 0) { throw "Failed to restore CPU limit on $container" }
    }
    finally {
        Pop-Location
    }
    Wait-Graph
}

@(
    "git_sha=$sha"
    "graph_image=$imageId"
    "original_nano_cpus=$originalNano"
    "k6_image=$k6Image"
    "gateway=http://host.docker.internal:8080"
) | Set-Content -Path (Join-Path $evidence 'header.txt') -Encoding utf8

$restored = $false
try {
    Write-Host "Pulling $k6Image"
    docker pull $k6Image
    if ($LASTEXITCODE -ne 0) { throw "docker pull $k6Image failed with exit $LASTEXITCODE" }
    Wait-Graph

    $attempts = @(
        @{ Name = 'isolated-normal'; Cpus = $null; Profile = 'normal' }
        @{ Name = 'cpus015-normal'; Cpus = 0.15; Profile = 'normal' }
        @{ Name = 'cpus015-elevated'; Cpus = 0.15; Profile = 'elevated' }
        @{ Name = 'cpus005-normal'; Cpus = 0.05; Profile = 'normal' }
        @{ Name = 'cpus005-elevated'; Cpus = 0.05; Profile = 'elevated' }
        @{ Name = 'cpus001-elevated'; Cpus = 0.01; Profile = 'elevated' }
    )

    $sawPass = $false
    foreach ($attempt in $attempts) {
        if ($null -eq $attempt.Cpus) {
            Restore-GraphCpu
        }
        else {
            $cpuText = $attempt.Cpus.ToString([cultureinfo]::InvariantCulture)
            docker update --cpus=$cpuText $container | Out-Null
            if ($LASTEXITCODE -ne 0) { throw "docker update --cpus=$cpuText failed" }
        }

        $nano = (docker inspect $container --format '{{.HostConfig.NanoCpus}}').Trim()
        $log = Join-Path $evidence "$($attempt.Name).log"
        $summary = "/out/$($attempt.Name).json"
        Write-Host "k6 $($attempt.Name) nano=$nano"
        docker run --rm `
            -v "${repo}/lab2/k6:/scripts" `
            -v "${evidence}:/out" `
            $k6Image `
            run --summary-export $summary -e "PROFILE=$($attempt.Profile)" -e GATEWAY=http://host.docker.internal:8080 /scripts/graph-read.js `
            > $log 2>&1
        $code = $LASTEXITCODE
        $summaryFile = Join-Path $evidence "$($attempt.Name).json"
        if (Test-Path $summaryFile) {
            $summaryText = [IO.File]::ReadAllText($summaryFile)
            $summaryText = [regex]::Replace($summaryText, '("token"\s*:\s*")[^"]*(")', '${1}REDACTED${2}')
            $utf8 = New-Object System.Text.UTF8Encoding $false
            [IO.File]::WriteAllText($summaryFile, $summaryText, $utf8)
        }
        "exit=$code nano_cpus=$nano profile=$($attempt.Profile)" | Add-Content -Path $log -Encoding utf8
        "name=$($attempt.Name) exit=$code nano_cpus=$nano profile=$($attempt.Profile)" |
            Add-Content -Path (Join-Path $evidence 'runs.txt') -Encoding utf8
        Write-Host "$($attempt.Name) exit=$code"

        $shaAfter = (git -C $repo rev-parse HEAD).Trim()
        if ($shaAfter -ne $sha) { throw "git SHA changed during the run: $sha -> $shaAfter" }

        if ($attempt.Name -eq 'isolated-normal') {
            if ($code -eq 0) { $sawPass = $true }
            else { throw "Isolated normal profile failed (exit $code). See $log" }
            continue
        }

        if ($code -ne 0) {
            Write-Host "False FAIL recorded at $($attempt.Name)"
            break
        }
    }

    if (-not $sawPass) { throw 'Isolated run did not pass.' }
}
finally {
    Restore-GraphCpu
    $restored = $true
    $nano = (docker inspect $container --format '{{.HostConfig.NanoCpus}}').Trim()
    "restored_nano_cpus=$nano" | Add-Content -Path (Join-Path $evidence 'header.txt') -Encoding utf8
    if ([int64]$nano -ne $originalNano) {
        throw "CPU limit was not restored. original=$originalNano now=$nano"
    }
}

if (-not $restored) { throw 'CPU restore did not run.' }
Write-Host 'Stability evidence written.'
