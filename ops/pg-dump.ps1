# Requires -Version 5
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

function Read-DotEnv([string]$Path) {
    $map = @{}
    foreach ($line in Get-Content -Path $Path) {
        if ($line -match '^\s*#' -or $line -notmatch '=') { continue }
        $parts = $line.Split('=', 2)
        $map[$parts[0].Trim()] = $parts[1].Trim().Trim('"').Trim("'")
    }
    return $map
}

$envFile = Join-Path $root ".env"
if (-not (Test-Path $envFile)) { throw ".env is missing" }
$cfg = Read-DotEnv $envFile
$db = $cfg["DB_NAME"]
$user = $cfg["DB_USER"]
if (-not $db -or -not $user) { throw "DB_NAME or DB_USER is missing in .env" }

New-Item -ItemType Directory -Force -Path (Join-Path $root "backups") | Out-Null
$stamp = [DateTime]::UtcNow.ToString("yyyyMMddTHHmmssZ")
$dest = Join-Path $root "backups\relativa-$stamp.dump"

docker exec relativa-postgres pg_dump -U $user -d $db -Fc -f /tmp/relativa.dump
if ($LASTEXITCODE -ne 0) { throw "pg_dump failed: $LASTEXITCODE" }
docker cp "relativa-postgres:/tmp/relativa.dump" $dest
if ($LASTEXITCODE -ne 0) { throw "docker cp failed: $LASTEXITCODE" }
Write-Output "dump_ok $dest"
