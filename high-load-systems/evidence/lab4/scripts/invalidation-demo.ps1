# Lab 4, defence step 2: invalidation on a write. POST /api/v1/workspaces/1/entity-graph/create -> next GET is a MISS with fresh data.
#   powershell -File high-load-systems/evidence/lab4/scripts/invalidation-demo.ps1
# The script creates ONE demo client entity ("CacheDemo") in workspace 1 (organization 1) and archives it at the end,
# so the seed data is unchanged afterwards (is_archived = true hides it from the graph).
. "$PSScriptRoot\common.ps1"
$ErrorActionPreference = 'Continue'

'=== Lab 4 demo 2: invalidation on write ==='
1..6 | ForEach-Object { Get-Graph | Out-Null }
Clear-CacheKeys

'--- Prepare: 3 cached variants for organization 1 (all / high / low) and 1 for organization 2'
Format-Probe 'org 1, all   (1st)' (Get-Graph)
Format-Probe 'org 1, all   (2nd)' (Get-Graph)
Format-Probe 'org 1, high' (Get-Graph -RiskLevel high)
Format-Probe 'org 1, low' (Get-Graph -RiskLevel low)
Format-Probe 'org 2, all (other tenant)' (Get-Graph -OrgId 2)
Show-CacheKeys 'before the write'
$before = Get-Graph
Format-Probe 'org 1, all   (HIT, before write)' $before
''

'--- WRITE: POST /api/v1/workspaces/1/entity-graph/create (through nginx, Round Robin picks any instance)'
$json = '{"entityTypeId":1,"properties":[{"propertyId":1,"value":"CacheDemo"},{"propertyId":3,"value":"Probe"},{"propertyId":5,"value":"cachedemo@example.com"}]}'
$file = Join-Path $env:TEMP 'lab4-create.json'
$json | Out-File -Encoding ascii $file
$resp = & curl.exe -s -m 60 -w '|HTTP %{http_code} %{time_total}s' -X POST -H 'X-User-Id: 1' -H 'Content-Type: application/json' --data-binary "@$file" "$($script:Lb)/api/v1/workspaces/1/entity-graph/create"
$newId = ([regex]::Match($resp, '^\{"id":(\d+)')).Groups[1].Value
"create answer: id=$newId  $($resp.Substring($resp.LastIndexOf('|') + 1))"
''
Show-CacheKeys 'right after the write (org 1 keys must be gone, org 2 key must survive)'
''
'--- READ after the write'
$after = Get-Graph
Format-Probe 'org 1, all   (after write)' $after
Format-Probe 'org 1, all   (next)' (Get-Graph)
Format-Probe 'org 1, high  (after write)' (Get-Graph -RiskLevel high)
Format-Probe 'org 2, all   (untouched)' (Get-Graph -OrgId 2)
''
'FRESHNESS: nodes before={0} after={1}; new label present in the response: {2}' -f $before.Nodes, $after.Nodes, ($after.Labels -contains 'CacheDemo')

# Cleanup: archive the demo entity (soft delete) and drop the cache so the next reader sees the seed state again.
if ($newId) {
    docker exec relativa-postgres psql -U relativa -d relativa -c "update entity set is_archived = true where id = $newId" | Out-Null
    Clear-CacheKeys
    "cleanup: entity $newId archived, cache cleared."
}
