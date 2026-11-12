# Lab 2 - Restart / Instance-Loss scenario.
#
# Part A  Graph under continuous traffic through nginx. Instance 1 is KILLED (docker kill = SIGKILL, no graceful
#         shutdown) mid-run, left dead for a while, then started again. Expected: every request still gets HTTP 200
#         (nginx retries idempotent requests on the surviving instance) and, while graph-1 is dead, only graph-2 answers.
# Part B  Business state. A write is made through Auth instance 1, then Auth instance 1 is killed. Instance 2
#         immediately serves the new value and accepts further writes. After instance 1 restarts it sees everything
#         that happened while it was dead. Nothing was lost because no state lived in the killed process.
#
# Usage:  powershell -File high-load-systems/evidence/lab2/scripts/restart-scenario.ps1

param(
    [string]$Lb = 'http://localhost:8090',
    [string]$Auth1 = 'http://localhost:8081',
    [string]$Auth2 = 'http://localhost:8087',
    [string]$GraphContainer = 'relativa-graph',
    [string]$AuthContainer = 'relativa-auth',
    [string]$Email = 'admin@relativa.com',
    [string]$Password = 'Demo1234!'
)

function Say([string]$m) { Write-Output ("[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $m) }
function Wait-Http([string]$url, [int]$timeoutSec = 60) {
    $end = (Get-Date).AddSeconds($timeoutSec)
    while ((Get-Date) -lt $end) { try { if ((Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 3).StatusCode -eq 200) { return $true } } catch {}; Start-Sleep -Milliseconds 500 }
    return $false
}

Write-Output "=== Part A: Graph via nginx while instance 1 ($GraphContainer) is killed ==="
$loop = Start-Job -ArgumentList $Lb -ScriptBlock {
    param($lb)
    $end = (Get-Date).AddSeconds(40)
    while ((Get-Date) -lt $end) {
        $t = Get-Date
        try {
            $r = Invoke-WebRequest -UseBasicParsing -Headers @{ 'X-User-Id' = '1' } -Uri "$lb/api/v1/graph?organizationId=1" -TimeoutSec 30
            [pscustomobject]@{ Time = $t; Status = [int]$r.StatusCode; Instance = $r.Headers['X-Instance-ID'] }
        } catch {
            $code = 0; if ($_.Exception.Response) { $code = [int]$_.Exception.Response.StatusCode }
            [pscustomobject]@{ Time = $t; Status = $code; Instance = '<error>' }
        }
        Start-Sleep -Milliseconds 200
    }
}
Start-Sleep -Seconds 8
$killedAt = Get-Date;  Say "docker kill $GraphContainer  (instance 1 lost)";  docker kill $GraphContainer | Out-Null
Start-Sleep -Seconds 15
$startedAt = Get-Date; Say "docker start $GraphContainer (instance 1 back)";  docker start $GraphContainer | Out-Null
Wait-Job $loop | Out-Null
$rows = Receive-Job $loop; Remove-Job $loop

$before = $rows | Where-Object { $_.Time -lt $killedAt }
$during = $rows | Where-Object { $_.Time -ge $killedAt -and $_.Time -lt $startedAt }
$after  = $rows | Where-Object { $_.Time -ge $startedAt }
function Summ($set) { ($set | Group-Object Instance, Status | Sort-Object Name | ForEach-Object { "{0} x{1}" -f ($_.Name -replace ', ', ' / HTTP '), $_.Count }) -join ';  ' }
Write-Output ("before kill   ({0,3} requests): {1}" -f @($before).Count, (Summ $before))
Write-Output ("instance dead ({0,3} requests): {1}" -f @($during).Count, (Summ $during))
Write-Output ("after restart ({0,3} requests): {1}" -f @($after).Count, (Summ $after))
$failed = @($rows | Where-Object { $_.Status -ne 200 }).Count
Write-Output ("RESULT total requests={0}  failed(non-200)={1}  served-by-graph-1-while-dead={2}" -f @($rows).Count, $failed, @($during | Where-Object { $_.Instance -eq 'graph-1' }).Count)

Write-Output ""
Write-Output "=== Part B: business state survives the loss of Auth instance 1 ($AuthContainer) ==="
$login = Invoke-RestMethod -Method Post -Uri "$Auth1/api/v1/auth/login" -ContentType 'application/json' -Body (@{ email = $Email; password = $Password } | ConvertTo-Json)
$auth = @{ Authorization = "Bearer $($login.accessToken)" }
$profile = Invoke-RestMethod -Uri "$Auth1/api/v1/auth/me" -Headers $auth
$original = $profile.lastName
function Set-LastName([string]$base, [string]$value) {
    $b = @{ firstName = $profile.firstName; lastName = $value; phone = $profile.phone; dateOfBirth = $profile.dateOfBirth } | ConvertTo-Json
    Invoke-RestMethod -Method Patch -Uri "$base/api/v1/auth/me" -Headers $auth -ContentType 'application/json' -Body $b | Out-Null
}
function Get-LastName([string]$base) { (Invoke-RestMethod -Uri "$base/api/v1/auth/me" -Headers $auth).lastName }
try {
    $v1 = "Lab2-before-kill-" + (Get-Date -Format 'HHmmss')
    Set-LastName $Auth1 $v1;                                   Say "write #1 through instance 1: lastName='$v1'"
    Say "docker kill $AuthContainer  (instance 1 lost, JWT issued by it is still in use)"; docker kill $AuthContainer | Out-Null
    Say "instance 2 reads : lastName='$(Get-LastName $Auth2)'   <- value written through the dead instance"
    $v2 = "Lab2-while-dead-" + (Get-Date -Format 'HHmmss')
    Set-LastName $Auth2 $v2;                                   Say "write #2 through instance 2 (instance 1 is dead): lastName='$v2'"
    Say "docker start $AuthContainer"; docker start $AuthContainer | Out-Null
    if (-not (Wait-Http "$Auth1/health" 90)) { Say "instance 1 did not become healthy in time" }
    $seen = Get-LastName $Auth1
    Say "instance 1 (restarted) reads : lastName='$seen'"
    if ($seen -eq $v2) { Write-Output "RESULT no data lost: the restarted instance sees the write made while it was dead" }
    else { Write-Output "RESULT DATA MISMATCH: expected '$v2'" }
}
finally {
    if (Wait-Http "$Auth1/health" 90) { Set-LastName $Auth1 $original; Say "(seed value lastName='$original' restored)" }
}
