# Helpers shared by run-k6.ps1 and run-staged.ps1 (dot-source it: . "$PSScriptRoot\lab5-lib.ps1").
#
# WHY THIS EXISTS (lesson of the first Lab 5 attempts, see CONTEXT.md): a write run (scenarios B and C) leaves side effects
# that keep consuming CPU AFTER k6 has finished and that grow from run to run:
#   * every create emits domain events -> RabbitMQ queues consumed by Graph (3 instances) and ML, minutes of work after the run;
#   * 2 audit_outbox rows per create (36 000 rows after ~18 000 creates) and the entities themselves (only archived before);
#   * the queue domain.events.ml.workspace.v1 has NO consumer and grew to 37 697 messages (RabbitMQ memory).
# Runs that came after a write run were slower for that reason alone (a 100-VU read run: 190 req/s clean, 50-95 req/s
# right after write runs). So before every run: delete the test data, purge the queues, wait until the system is idle.

$script:Marker = 'Lab5WriteTest'
# audit_outbox rows created since the first Lab 5 test (nothing else writes during the lab); older rows (22) are kept.
$script:OutboxSince = '2026-11-11 23:00:00+00'

function Invoke-Psql($sql) {
    (docker exec relativa-postgres psql -U relativa relativa -tAc $sql 2>&1 | Out-String).Trim()
}

function Count-TestEntities {
    Invoke-Psql "select count(*) from entity e join entity_property_value v on v.entity_id = e.id and v.property_id = 1 and v.value_string = '$($script:Marker)'"
}

# DELETE (not archive) the entities created by the load tests, with their workspace links and property values (ON DELETE
# CASCADE), and the audit_outbox rows they produced. Then VACUUM ANALYZE so the planner/table sizes are back to normal.
function Reset-TestData([switch] $Full) {
    Invoke-Psql "delete from entity where id in (select entity_id from entity_property_value where property_id = 1 and value_string = '$($script:Marker)')" | Out-Null
    Invoke-Psql "delete from audit_outbox where created_at_utc >= '$($script:OutboxSince)'" | Out-Null
    $v = if ($Full) { 'VACUUM (FULL, ANALYZE) entity, entity_workspace, entity_property_value, audit_outbox' } else { 'VACUUM (ANALYZE) entity, entity_workspace, entity_property_value, audit_outbox' }
    Invoke-Psql $v | Out-Null
}

# Empties the queues that load tests fill. domain.events.ml.workspace.v1 has no consumer at all.
function Purge-Queues {
    foreach ($q in 'ml.graph.score_request.v1', 'domain.events.ml.workspace.v1', 'domain.events.graph.ml.v1', 'domain.events.graph.workspace.v1', 'domain.events.ml.recalculate.v1', 'core.entity_graph.create') {
        docker exec relativa-rabbitmq rabbitmqctl purge_queue $q 2>&1 | Out-Null
    }
}

# Waits until (a) all queues are empty and (b) the CPU of the services is low, three polls in a row. Returns the seconds waited.
function Wait-Settled([int] $MaxSeconds = 900) {
    $t0 = Get-Date
    $calm = 0
    while (((Get-Date) - $t0).TotalSeconds -lt $MaxSeconds) {
        $q = docker exec relativa-rabbitmq rabbitmqctl list_queues name messages messages_unacknowledged 2>&1 |
            Where-Object { $_ -match '^\S+\s+\d+\s+\d+' }
        $backlog = 0
        foreach ($line in $q) { $p = $line -split '\s+'; $backlog += [int]$p[1] + [int]$p[2] }
        $busy = 0
        docker stats --no-stream --format '{{.Name}} {{.CPUPerc}}' 2>&1 | ForEach-Object {
            if ($_ -match '^(relativa-(graph|graph-2|graph-3|ml|core|auth|auth-2|rabbitmq|postgres)) ([\d.]+)%') { if ([double]$Matches[3] -gt 8) { $busy++ } }
        }
        if ($backlog -eq 0 -and $busy -eq 0) { $calm++ } else { $calm = 0 }
        if ($calm -ge 3) { break }
        Start-Sleep -Seconds 5
    }
    [int]((Get-Date) - $t0).TotalSeconds
}

# PostgreSQL work counters of the lab database (cumulative): transactions, rows returned, rows fetched, blocks read+hit.
function Get-DbCounters {
    $r = Invoke-Psql "select xact_commit + xact_rollback, tup_returned, tup_fetched, blks_hit + blks_read from pg_stat_database where datname = 'relativa'"
    $p = $r -split '\|'
    @([int64]$p[0], [int64]$p[1], [int64]$p[2], [int64]$p[3])
}

# Reads the docker stats stream (lines "HH:mm:ss name cpu% mem") and prints, per container, the average and the maximum CPU %
# between two times (the 60 s hold). 100% = one core. Runs where a container is missing in the window print nothing for it.
function Summarize-Stats($file, [datetime] $from, [datetime] $to) {
    if (-not (Test-Path $file)) { return "(no docker stats stream)" }
    $rows = Get-Content $file | ForEach-Object {
        $l = ($_ -replace '\x1b\[[0-9;]*[A-Za-z]', '').Trim()
        if ($l -match '^(\d\d:\d\d:\d\d)\s+(relativa-[\w-]+|lab5-k6)\s+([\d.]+)%\s+([\d.]+)(MiB|GiB)') {
            $time = [datetime]::ParseExact($Matches[1], 'HH:mm:ss', $null)
            $time = (Get-Date).Date.Add($time.TimeOfDay)
            [pscustomobject]@{ T = $time; Name = $Matches[2]; Cpu = [double]$Matches[3]; Mem = [double]$Matches[4] * $(if ($Matches[5] -eq 'GiB') { 1024 } else { 1 }) }
        }
    }
    $inWin = $rows | Where-Object { $_.T -ge $from -and $_.T -le $to }
    "docker stats stream, window $($from.ToString('HH:mm:ss'))-$($to.ToString('HH:mm:ss')) (CPU % of one core, avg / max over $(@($inWin | Where-Object Name -eq 'relativa-graph').Count) samples):"
    $inWin | Group-Object Name | Sort-Object Name | ForEach-Object {
        $m = $_.Group | Measure-Object Cpu -Average -Maximum
        $mem = ($_.Group | Measure-Object Mem -Maximum).Maximum
        "{0,-20} cpu avg={1,6:N1}% max={2,6:N1}%  mem max={3,7:N0} MiB" -f $_.Name, $m.Average, $m.Maximum, $mem
    }
}

