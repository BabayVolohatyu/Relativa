# Lab 4, "before" evidence: the ORIGINAL Graph image (no cache) answers the same request every time from PostgreSQL + ML.
# Run it against the pre-lab stand (docker-compose ... -f high-load-systems/evidence/lab4/scripts/orig-image.override.yml).
#   powershell -File high-load-systems/evidence/lab4/scripts/before-no-cache-demo.ps1
. "$PSScriptRoot\common.ps1"
$ErrorActionPreference = 'Continue'

'=== Lab 4 BEFORE: original code, no cache ==='
1..6 | ForEach-Object { Get-Graph | Out-Null }
Clear-CacheKeys   # remove keys left by an earlier run of the Lab 4 image, so the output shows what THIS code writes
Show-CacheKeys 'before the requests'
$ms = @()
1..9 | ForEach-Object { $r = Get-Graph; $ms += $r.Ms; Format-Probe "request $_" $r }
Show-CacheKeys 'after the requests (the original code writes nothing to Redis)'
$s = $ms | Sort-Object
'latency of 9 identical requests: min={0} median={1} max={2} ms; X-Cache header present: no (shown as "-")' -f $s[0], $s[4], $s[-1]
''
'--- Redis stopped: the original code does not use Redis for this endpoint, so nothing changes (it never benefited from it)'
docker stop $script:Redis | Out-Null
try { Format-Probe 'redis DOWN request' (Get-Graph) } finally { docker start $script:Redis | Out-Null }
