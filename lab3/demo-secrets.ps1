# Crash test: a published AWS sample key must FAIL the pre-commit hook,
# then a clean tree must PASS. The sample is Amazon's documentation key and is never committed.
$ErrorActionPreference = 'Continue'
$env:PATH = "$env:LOCALAPPDATA\Microsoft\WinGet\Links;" + $env:PATH
$repo = Split-Path $PSScriptRoot -Parent
Set-Location $repo
$evidence = Join-Path $PSScriptRoot 'evidence'
New-Item -ItemType Directory -Force -Path $evidence | Out-Null

$trapDir = Join-Path $PSScriptRoot 'secrets-trap'
$trapFile = Join-Path $trapDir 'local.settings.json'
New-Item -ItemType Directory -Force -Path $trapDir | Out-Null

$before = git rev-parse HEAD
@'
{
  "aws_access_key_id": "AKIAIOSFODNN7EXAMPLE",
  "aws_secret_access_key": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}
'@ | Set-Content -Path $trapFile -Encoding utf8

git add -f -- lab3/secrets-trap/local.settings.json
$commit = cmd /c "git commit -m `"lab3: crash-test synthetic secret`" 2>&1"
$commitCode = $LASTEXITCODE
[System.IO.File]::WriteAllText((Join-Path $evidence 'secrets-fail.txt'), (($commit | Out-String).Trim() + "`nexit=$commitCode`n"))

git restore --staged -- lab3/secrets-trap/local.settings.json
Remove-Item -Force $trapFile
if (Test-Path $trapDir) {
    $left = Get-ChildItem $trapDir -Force
    if (-not $left) { Remove-Item -Force $trapDir }
}

$after = git rev-parse HEAD
if ($before -ne $after) {
    git reset --soft $before | Out-Null
    git restore --staged -- lab3/secrets-trap/local.settings.json 2>$null
    Write-Error "The crash-test commit landed and was removed. HEAD is $before again."
    exit 1
}
if ($commitCode -eq 0) {
    Write-Error "The pre-commit hook exited 0 for a staged synthetic secret."
    exit 1
}

$history = git log --all --oneline -- lab3/secrets-trap/local.settings.json
if ($history) {
    Write-Error "The trap file is present in commit history."
    exit 1
}

$pass = cmd /c "gitleaks detect --source . --config .gitleaks.toml --redact --no-banner --exit-code 1 2>&1"
$passCode = $LASTEXITCODE
[System.IO.File]::WriteAllText((Join-Path $evidence 'secrets-pass.txt'), (($pass | Out-String).Trim() + "`nexit=$passCode`n"))
if ($passCode -ne 0) {
    Write-Error "gitleaks detect failed after the trap file was removed. See lab3/evidence/secrets-pass.txt"
    exit $passCode
}

Write-Host "FAIL exit=$commitCode"
Get-Content (Join-Path $evidence 'secrets-fail.txt')
Write-Host "PASS exit=$passCode"
Get-Content (Join-Path $evidence 'secrets-pass.txt')
