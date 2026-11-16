# Point this clone at the committed hooks. Writes only this repo's .git/config.
$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
git -C $repo config core.hooksPath .githooks
Write-Host "core.hooksPath=.githooks"
