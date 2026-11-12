# Rebuilds resources.runN.txt from cpu-stream.runN.txt for runs where the summary was lost.
# (A bug in the first version of run-k6.ps1 deleted resources.runN.txt right after writing it; the raw stream was kept.)
# Window: from the first stream line + 27 s (stream starts about 2 s before k6, ramp-up is 15 s, k6 needs a few seconds to start)
# to the last stream line - 6 s. Run it for the folders you list:  .\regen-resources.ps1   (all folders that have a cpu-stream file)
param([string] $Root = (Join-Path $PSScriptRoot '..\k6'))
. "$PSScriptRoot\lab5-lib.ps1"
Get-ChildItem $Root -Recurse -Filter 'cpu-stream.run*.txt' | ForEach-Object {
    $run = $_.Name -replace 'cpu-stream\.(run\d+)\.txt', '$1'
    $target = Join-Path $_.DirectoryName "resources.$run.txt"
    if (Test-Path $target) { return }
    $times = Get-Content $_.FullName | ForEach-Object { if ((($_ -replace '\x1b\[[0-9;]*[A-Za-z]', '').Trim()) -match '^(\d\d:\d\d:\d\d)\s') { $Matches[1] } }
    $first = (Get-Date).Date.Add([datetime]::ParseExact($times[0], 'HH:mm:ss', $null).TimeOfDay)
    $last = (Get-Date).Date.Add([datetime]::ParseExact($times[-1], 'HH:mm:ss', $null).TimeOfDay)
    Summarize-Stats $_.FullName $first.AddSeconds(27) $last.AddSeconds(-6) | Out-File -Encoding utf8 $target
    "regenerated $target"
}
