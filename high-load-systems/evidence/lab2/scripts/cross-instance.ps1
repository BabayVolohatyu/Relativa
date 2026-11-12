# Lab 2 - Cross-Instance Consistency (no sticky sessions).
#
# Part A  Graph behind nginx (round-robin, no affinity): 10 identical reads, X-Instance-ID alternates and the
#         response body is byte-identical no matter which instance answered.
# Part B  The chain required by the lab - POST -> instance 1, GET -> instance 2, PATCH(PUT) -> instance 2, GET -> instance 1 -
#         executed against the two Auth instances (the Graph service is read-only, Auth owns write endpoints).
#         The JWT is validated statelessly (shared signing key), the data lives in PostgreSQL.
# Part C  What actually sits in Redis (the externalised state).
#
# Usage:  powershell -File high-load-systems/evidence/lab2/scripts/cross-instance.ps1

param(
    [string]$Lb      = 'http://localhost:8090',
    [string]$Auth1   = 'http://localhost:8081',
    [string]$Auth2   = 'http://localhost:8087',
    [string]$Email   = 'admin@relativa.com',
    [string]$Password = 'Demo1234!'
)

function Invoke-Api([string]$Method, [string]$Url, $Body = $null, [hashtable]$Headers = @{}) {
    $args = @{ UseBasicParsing = $true; Method = $Method; Uri = $Url; Headers = $Headers }
    if ($Body) { $args.Body = ($Body | ConvertTo-Json); $args.ContentType = 'application/json' }
    Invoke-WebRequest @args
}
function Iid($r) { $v = $r.Headers['X-Instance-ID']; if ($v) { $v } else { '<none>' } }

Write-Output "=== Part A: Graph via nginx ($Lb) - 10 reads, no sticky sessions ==="
$hashes = @{}; $perInstance = @{}
foreach ($i in 1..10) {
    $r = Invoke-Api GET "$Lb/api/v1/graph?organizationId=1" -Headers @{ 'X-User-Id' = '1' }
    $iid = Iid $r
    # Fingerprint = sorted node ids + edge ids. The ML highlight tags are deliberately excluded: they depend on whether the
    # ML service answered within the 200 ms scoring budget (MlScoringResilience), which varies per request, not per instance.
    $json = $r.Content | ConvertFrom-Json
    $structure = (($json.nodes | ForEach-Object { $_.id } | Sort-Object) -join ',') + '|' + (($json.edges | ForEach-Object { $_.id } | Sort-Object) -join ',')
    $sha = [BitConverter]::ToString([Security.Cryptography.SHA256]::Create().ComputeHash([Text.Encoding]::UTF8.GetBytes($structure))).Replace('-', '').Substring(0, 12)
    $perInstance[$iid] = 1 + [int]$perInstance[$iid]; $hashes[$sha] = 1 + [int]$hashes[$sha]
    Write-Output ("GET /api/v1/graph  -> HTTP {0}  X-Instance-ID={1}  nodes={2} edges={3}  structure-sha256[0..12]={4}" -f $r.StatusCode, $iid, @($json.nodes).Count, @($json.edges).Count, $sha)
}
Write-Output ("requests per instance : " + (($perInstance.GetEnumerator() | Sort-Object Name | ForEach-Object { "$($_.Name)=$($_.Value)" }) -join '  '))
Write-Output ("distinct graph structures: {0}  (1 => every instance returned the same nodes and edges)" -f $hashes.Count)

Write-Output ""
Write-Output "=== Part B: POST -> inst.1, GET -> inst.2, PATCH -> inst.2, GET -> inst.1 (Auth service) ==="
$login = Invoke-Api POST "$Auth1/api/v1/auth/login" @{ email = $Email; password = $Password }
$token = ($login.Content | ConvertFrom-Json).accessToken
Write-Output ("1. POST  {0}/api/v1/auth/login          -> HTTP {1}  X-Instance-ID={2}  (JWT issued)" -f $Auth1, $login.StatusCode, (Iid $login))
$auth = @{ Authorization = "Bearer $token" }

$me2 = Invoke-Api GET "$Auth2/api/v1/auth/me" -Headers $auth
$profile = $me2.Content | ConvertFrom-Json
Write-Output ("2. GET   {0}/api/v1/auth/me             -> HTTP {1}  X-Instance-ID={2}  lastName='{3}'  (token from inst.1 accepted by inst.2)" -f $Auth2, $me2.StatusCode, (Iid $me2), $profile.lastName)

$original = $profile.lastName
$marker = "Lab2-" + (Get-Date -Format 'HHmmss')
try {
    $patchBody = @{ firstName = $profile.firstName; lastName = $marker; phone = $profile.phone; dateOfBirth = $profile.dateOfBirth }
    $patch = Invoke-Api PATCH "$Auth2/api/v1/auth/me" $patchBody $auth
    Write-Output ("3. PATCH {0}/api/v1/auth/me             -> HTTP {1}  X-Instance-ID={2}  lastName set to '{3}'" -f $Auth2, $patch.StatusCode, (Iid $patch), $marker)

    $me1 = Invoke-Api GET "$Auth1/api/v1/auth/me" -Headers $auth
    $seen = ($me1.Content | ConvertFrom-Json).lastName
    Write-Output ("4. GET   {0}/api/v1/auth/me             -> HTTP {1}  X-Instance-ID={2}  lastName='{3}'" -f $Auth1, $me1.StatusCode, (Iid $me1), $seen)
    if ($seen -eq $marker) { Write-Output "RESULT consistent: instance 1 sees the write made through instance 2" }
    else { Write-Output "RESULT INCONSISTENT: expected '$marker' but instance 1 returned '$seen'" }
}
finally {
    # restore the seeded value so the demo leaves no trace
    $restore = @{ firstName = $profile.firstName; lastName = $original; phone = $profile.phone; dateOfBirth = $profile.dateOfBirth }
    Invoke-Api PATCH "$Auth1/api/v1/auth/me" $restore $auth | Out-Null
    Write-Output "(seed value lastName='$original' restored)"
}

Write-Output ""
Write-Output "=== Part C: keys held in Redis (shared state) ==="
docker exec relativa-redis redis-cli --scan --pattern '*'
Write-Output "-- active pub/sub channels (SignalR backplane):"
docker exec relativa-redis redis-cli pubsub channels
