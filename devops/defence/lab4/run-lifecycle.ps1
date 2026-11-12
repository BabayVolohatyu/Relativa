# Re-runs the whole Helm release lifecycle of lab 4 and writes the raw outputs to
# devops/evidence/lab4. Run from the repository root with minikube started:
#   powershell -ExecutionPolicy Bypass -File devops/defence/lab4/run-lifecycle.ps1
$ErrorActionPreference = "Continue"
Set-Location (Resolve-Path "$PSScriptRoot\..\..\..")
$ev = "devops\evidence\lab4"
$ns = "relativa-helm"
New-Item -ItemType Directory -Force $ev | Out-Null

function Ev($file, $cmds) {
  $p = Join-Path $ev $file
  "" | Out-File $p -Encoding utf8
  foreach ($c in $cmds) {
    "`$ $c" | Out-File $p -Append -Encoding utf8
    (Invoke-Expression $c 2>&1 | Out-String) | Out-File $p -Append -Encoding utf8
  }
}
$health = "minikube ssh -- curl -sS -m 5 http://127.0.0.1:`$(kubectl get svc -n $ns relativa-gateway -o jsonpath='{.spec.ports[0].nodePort}')/health"

# 01 lint, three value sets
Ev "01-lint.txt" @("helm lint helm/", "helm lint helm/ -f helm/values-dev.yaml", "helm lint helm/ -f helm/values-prod.yaml")

# 02 render without installing: dev vs prod, precedence, comparison with lab 3
helm template relativa helm/ -n $ns | Out-File "$ev\02-template-dev.yaml" -Encoding utf8
helm template relativa helm/ -n $ns -f helm/values-prod.yaml | Out-File "$ev\02-template-prod.yaml" -Encoding utf8
$d = git diff --no-index --no-color --unified=1 "$ev\02-template-dev.yaml" "$ev\02-template-prod.yaml" | Out-String
"# helm template (dev defaults) vs helm template -f values-prod.yaml, nothing installed in the cluster`n`$ helm template relativa helm/ > dev.yaml`n`$ helm template relativa helm/ -f helm/values-prod.yaml > prod.yaml`n`$ diff dev.yaml prod.yaml`n" + $d | Out-File "$ev\02-diff-dev-prod.txt" -Encoding utf8
$prio = "helm template relativa helm/ | Select-String 'replicas:|image: .relativa-gateway'",
        "helm template relativa helm/ -f helm/values-prod.yaml | Select-String 'replicas:|image: .relativa-gateway'",
        "helm template relativa helm/ -f helm/values-prod.yaml --set gateway.replicaCount=5 --set gateway.image.tag=9.9.9 | Select-String 'replicas:|image: .relativa-gateway'"
Ev "02-values-priority.txt" (@("# Priority: values.yaml < -f file < --set (the last one wins)") + $prio)
$c3 = "$ev\02-compare-lab3.txt"
"# Objects of the lab3 manifests (k8s/) vs objects rendered by the chart" | Out-File $c3 -Encoding utf8
"`n## lab3: kubectl create --dry-run=client -f k8s/ -o name" | Out-File $c3 -Append -Encoding utf8
(kubectl create --dry-run=client -f k8s/ -o name 2>&1 | Out-String) | Out-File $c3 -Append -Encoding utf8
$pat = "(?ms)^kind: (\w+)\r?\nmetadata:\r?\n  name: (\S+)"
"## chart, dev values: kind/name" | Out-File $c3 -Append -Encoding utf8
([regex]::Matches((helm template relativa helm/ -n $ns | Out-String), $pat) | ForEach-Object { "$($_.Groups[1].Value)/$($_.Groups[2].Value)" }) -join "`n" | Out-File $c3 -Append -Encoding utf8
"`n## chart, prod values: kind/name (adds Ingress)" | Out-File $c3 -Append -Encoding utf8
([regex]::Matches((helm template relativa helm/ -n $ns -f helm/values-prod.yaml | Out-String), $pat) | ForEach-Object { "$($_.Groups[1].Value)/$($_.Groups[2].Value)" }) -join "`n" | Out-File $c3 -Append -Encoding utf8

# 03 install (namespace is created by Helm, not by a template)
Ev "03-install.txt" @(
  "helm install relativa helm/ -n $ns --create-namespace --wait --timeout 5m",
  "kubectl get all,pvc,configmap,secret -n $ns")

# 04 releases, status, values
Ev "04-status.txt" @(
  "helm list -n $ns",
  "helm list -A",
  "helm status relativa -n $ns --show-resources",
  "helm get values relativa -n $ns",
  "helm get values relativa -n $ns --all",
  "helm get manifest relativa -n $ns | Select-String '^kind:|^  name:'",
  "kubectl exec -n $ns deploy/relativa-gateway -- printenv Relativa__AppName Jwt__Issuer Jwt__Audience POD_NAME",
  $health)

# 05 where Helm keeps the release state
$p = "$ev\05-helm-state.txt"
"" | Out-File $p -Encoding utf8
"`$ kubectl get secrets -n $ns -l owner=helm" | Out-File $p -Append -Encoding utf8
(kubectl get secrets -n $ns -l owner=helm | Out-String) | Out-File $p -Append -Encoding utf8
"`$ kubectl describe secret sh.helm.release.v1.relativa.v1 -n $ns" | Out-File $p -Append -Encoding utf8
(kubectl describe secret sh.helm.release.v1.relativa.v1 -n $ns | Out-String) | Out-File $p -Append -Encoding utf8
"`$ decode the 'release' key: base64 -> base64 -> gunzip -> JSON (selected fields)" | Out-File $p -Append -Encoding utf8
$b = kubectl get secret sh.helm.release.v1.relativa.v1 -n $ns -o jsonpath='{.data.release}'
$py = @"
import sys, base64, gzip, json
raw = sys.stdin.read().strip()
d = json.loads(gzip.decompress(base64.b64decode(base64.b64decode(raw))))
print(json.dumps({'name': d['name'], 'namespace': d['namespace'], 'revision': d['version'],
  'info.status': d['info']['status'], 'chart.name': d['chart']['metadata']['name'],
  'chart.version': d['chart']['metadata']['version'], 'chart.appVersion': d['chart']['metadata']['appVersion'],
  'user_values': d.get('config'), 'manifest_bytes': len(d['manifest']),
  'templates': [t['name'] for t in d['chart']['templates']]}, indent=2))
"@
($b | python -c $py 2>&1 | Out-String) | Out-File $p -Append -Encoding utf8

# 05b the same chart twice in one cluster
Ev "05b-install-twice.txt" @(
  "helm install second helm/ -n $ns --wait --timeout 5m | Select-Object -First 6",
  "helm list -n $ns",
  "kubectl get deploy,svc,pvc -n $ns",
  "helm uninstall second -n $ns",
  "helm list -n $ns")

# 06 upgrade with --set
Ev "06-upgrade-set.txt" @(
  "helm upgrade relativa helm/ -n $ns --set gateway.image.tag=1.1.0 --wait --timeout 5m | Select-Object -First 6",
  "helm get values relativa -n $ns",
  "kubectl get deploy relativa-gateway -n $ns -o jsonpath='{.spec.template.spec.containers[0].image}'",
  "kubectl get pods -n $ns",
  $health,
  "kubectl get events -n $ns --field-selector involvedObject.name=relativa-pre-upgrade-check --sort-by=.lastTimestamp")

# 07 upgrade with the prod values file
Ev "07-upgrade-prod.txt" @(
  "helm upgrade relativa helm/ -n $ns -f helm/values-prod.yaml --wait --timeout 6m | Select-Object -First 6",
  "helm get values relativa -n $ns",
  "kubectl get deploy,pods,ingress -n $ns",
  "kubectl get deploy relativa-gateway -n $ns -o jsonpath='{.spec.template.spec.containers[0].resources}'",
  $health)

# 08 history
Ev "08-history.txt" @(
  "helm history relativa -n $ns",
  "helm get values relativa -n $ns --revision 1",
  "helm get values relativa -n $ns --revision 2",
  "helm get values relativa -n $ns --revision 3",
  "kubectl get secrets -n $ns -l owner=helm",
  "kubectl get rs -n $ns")

# 09 rollback
Ev "09-rollback.txt" @(
  "helm rollback relativa 1 -n $ns --wait --timeout 5m",
  "helm history relativa -n $ns",
  "helm get values relativa -n $ns --all | Select-String 'replicaCount|tag:'",
  "kubectl get deploy,pods,ingress -n $ns",
  $health)

# 11 helm test
Ev "11-test.txt" @(
  "helm test relativa -n $ns --timeout 3m | Select-Object -First 10",
  "kubectl get pods -n $ns",
  "helm get hooks relativa -n $ns | Select-String 'helm.sh/hook|name:'")

# 11b a failing pre-upgrade hook aborts the upgrade, then rollback heals the release
Ev "11b-hook-failure.txt" @(
  "# Deliberately broken upgrade: the hook probes a wrong database port, so Helm must not touch the running objects",
  "helm upgrade relativa helm/ -n $ns --set postgres.service.port=5999 --timeout 1m 2>&1",
  "kubectl get pod relativa-pre-upgrade-check -n $ns",
  "kubectl logs relativa-pre-upgrade-check -n $ns",
  "helm history relativa -n $ns",
  "helm list -n $ns",
  "kubectl get deploy,svc -n $ns",
  "kubectl delete pod relativa-pre-upgrade-check -n $ns",
  "helm rollback relativa 4 -n $ns --wait --timeout 5m",
  "helm history relativa -n $ns")

# 10 uninstall in one command, namespace must be empty
Ev "10-uninstall.txt" @(
  "kubectl get all,pvc,configmap,secret,ingress -n $ns",
  "helm uninstall relativa -n $ns --wait",
  "helm list -n $ns",
  "Start-Sleep -Seconds 20; kubectl get all,pvc,configmap,secret,ingress -n $ns")

