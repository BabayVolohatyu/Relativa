$token = $env:SONAR_TOKEN
$base64Auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${token}:"))
$headers = @{ Authorization = "Basic $base64Auth" }

$url = "http://localhost:9000/api/measures/component?component=Relativa&metricKeys=bugs,vulnerabilities,security_hotspots,code_smells,sqale_index,duplicated_lines_density,cognitive_complexity,complexity,coverage"

$response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
$response.component.measures | Select-Object metric, value