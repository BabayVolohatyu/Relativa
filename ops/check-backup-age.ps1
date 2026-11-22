# Requires -Version 5
param(
    [string]$Directory = "",
    [int]$MaxAgeHours = 24
)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
if (-not $Directory) { $Directory = Join-Path $root "backups" }

$newest = Get-ChildItem -Path $Directory -Filter "relativa-*.dump" -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTimeUtc -Descending |
    Select-Object -First 1
if (-not $newest) {
    Write-Output "BackupStale no dump in $Directory"
    exit 1
}
$age = ([DateTime]::UtcNow - $newest.LastWriteTimeUtc).TotalHours
if ($age -gt $MaxAgeHours) {
    Write-Output "BackupStale age_hours=$([math]::Round($age, 2)) file=$($newest.Name)"
    exit 1
}
Write-Output "backup_fresh age_hours=$([math]::Round($age, 2)) file=$($newest.Name)"
exit 0
