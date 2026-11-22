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

$cfg = Read-DotEnv (Join-Path $root ".env")
$user = $cfg["DB_USER"]
$db = $cfg["DB_NAME"]
if (-not $user -or -not $db) { throw "DB_USER or DB_NAME is missing in .env" }

$dump = Get-ChildItem (Join-Path $root "backups") -Filter "relativa-*.dump" |
    Sort-Object LastWriteTimeUtc -Descending |
    Select-Object -First 1
if (-not $dump) { throw "no dump in backups/" }

function Invoke-Psql([string]$Database, [string]$Sql) {
    docker exec relativa-postgres psql -U $user -d $Database -v ON_ERROR_STOP=1 -t -A -c $Sql
    if ($LASTEXITCODE -ne 0) { throw "psql failed on $Database" }
}

docker exec relativa-postgres psql -U $user -d postgres -v ON_ERROR_STOP=1 -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'relativa_drill' AND pid <> pg_backend_pid();" | Out-Null
docker exec relativa-postgres psql -U $user -d postgres -v ON_ERROR_STOP=1 -c "DROP DATABASE IF EXISTS relativa_drill;"
if ($LASTEXITCODE -ne 0) { throw "drop drill failed" }
docker exec relativa-postgres psql -U $user -d postgres -v ON_ERROR_STOP=1 -c "CREATE DATABASE relativa_drill;"
if ($LASTEXITCODE -ne 0) { throw "create drill failed" }

docker cp $dump.FullName "relativa-postgres:/tmp/relativa-drill.dump"
if ($LASTEXITCODE -ne 0) { throw "docker cp failed" }
docker exec relativa-postgres pg_restore -U $user -d relativa_drill --no-owner --exit-on-error /tmp/relativa-drill.dump
if ($LASTEXITCODE -ne 0) { throw "pg_restore failed: $LASTEXITCODE" }

$sql = "SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public'"
$sourceCount = (Invoke-Psql $db $sql).Trim()
$drillCount = (Invoke-Psql "relativa_drill" $sql).Trim()
if ($sourceCount -ne $drillCount) { throw "table count $sourceCount != $drillCount" }
Write-Output "drill_ok tables=$drillCount dump=$($dump.Name)"
