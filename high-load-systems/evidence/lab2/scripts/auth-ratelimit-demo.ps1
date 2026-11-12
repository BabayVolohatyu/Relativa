# Lab 2 - proves where the e-mail/support rate-limit counter lives.
#
# POST /api/v1/support/contact is limited to 5 requests per client IP per hour (Support:MaxPerIpPerHour).
# We send 5 requests to auth instance 1 (:8081) and 5 more to auth instance 2 (:8087) with the SAME
# client IP (X-Forwarded-For). The limit is 5 per IP per hour, so a correct system accepts 5 in total.
#
#   in-memory counter (ConcurrentDictionary)  -> each instance has its own counter -> 10 accepted (BUG)
#   Redis counter                              -> one shared counter                -> 5 accepted, 5 rejected (429)
#
# Usage:  powershell -File high-load-systems/evidence/lab2/scripts/auth-ratelimit-demo.ps1

param(
    [string]$Instance1 = 'http://localhost:8081',
    [string]$Instance2 = 'http://localhost:8087',
    [string]$ClientIp  = "198.51.100.$(Get-Random -Minimum 1 -Maximum 250)"  # fresh IP => fresh counter
)

$body = @{ name = 'Lab2'; email = 'lab2@example.com'; subject = 'rate limit probe'; message = 'lab2 probe' } | ConvertTo-Json

function Send-Probe([string]$baseUrl) {
    try {
        $r = Invoke-WebRequest -UseBasicParsing -Method Post -Uri "$baseUrl/api/v1/support/contact" `
            -ContentType 'application/json' -Headers @{ 'X-Forwarded-For' = $ClientIp } -Body $body
        return [int]$r.StatusCode
    } catch {
        return [int]$_.Exception.Response.StatusCode
    }
}

Write-Output "Client IP used for the whole test: $ClientIp  (limit = 5 / hour / IP)"
$codes = @()
foreach ($i in 1..5) { $c = Send-Probe $Instance1; $codes += $c; Write-Output ("request {0,2} -> instance 1 ({1}) : HTTP {2}" -f $i, $Instance1, $c) }
foreach ($i in 6..10) { $c = Send-Probe $Instance2; $codes += $c; Write-Output ("request {0,2} -> instance 2 ({1}) : HTTP {2}" -f $i, $Instance2, $c) }

$accepted = ($codes | Where-Object { $_ -eq 204 }).Count
$rejected = ($codes | Where-Object { $_ -eq 429 }).Count
Write-Output ""
Write-Output "RESULT accepted(204)=$accepted rejected(429)=$rejected   (correct shared limit => accepted=5 rejected=5)"
