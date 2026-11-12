# relativa Helm chart

Helm 3 chart for the Relativa gateway and its PostgreSQL database. It replaces the plain manifests from lab 3 (`k8s/`) and produces the same set of objects:
ConfigMap, Secret, PersistentVolumeClaim, two Deployments, two Services and an optional Ingress. The Namespace is created by Helm (`--create-namespace`), not by a template.

## `version` and `appVersion`

| Field | Value | Meaning in this project |
|---|---|---|
| `version` | `1.0.0` | Version of the chart as a package: templates, values schema, helpers. Changes when the chart changes, for example a new template or a renamed value. |
| `appVersion` | `1.0.0` | Version of the application the chart ships by default: the `relativa-gateway` image tag. Changes when a new gateway image is released. |

They are independent. Changing `gateway.image.tag` to `1.1.0` in `values-prod.yaml` needs no chart release. Adding a `PodDisruptionBudget` template while the image stays `1.0.0` bumps `version` only.

## Prerequisites

- Helm 3 (`helm version`), kubectl, a running minikube.
- Images loaded into minikube (there is no registry): `minikube image load relativa-gateway:1.0.0` and `minikube image load relativa-gateway:1.1.0`.

## Install

```text
# dev (chart defaults), one command, clean cluster
helm install relativa helm/ -n relativa-helm --create-namespace

# dev with the explicit dev file
helm install relativa helm/ -n relativa-helm --create-namespace -f helm/values-dev.yaml

# prod
helm install relativa helm/ -n relativa-helm --create-namespace -f helm/values-prod.yaml \
  --set secret.jwtSecretKey="$JWT_KEY" --set secret.postgresPassword="$DB_PASSWORD"
```

Other useful commands:

```text
helm lint helm/
helm template relativa helm/ -f helm/values-prod.yaml
helm upgrade relativa helm/ -n relativa-helm --set gateway.image.tag=1.1.0
helm history relativa -n relativa-helm
helm rollback relativa 1 -n relativa-helm
helm test relativa -n relativa-helm
helm uninstall relativa -n relativa-helm
```

## Value precedence

From weakest to strongest: chart `values.yaml` < files passed with `-f` (later file wins) < `--set` / `--set-string`. Only keys that are set are overridden, the rest keep the lower level value.

## Values

| Key | Default (dev) | Description |
|---|---|---|
| `nameOverride`, `fullnameOverride` | `""` | Override chart name or the whole generated name prefix. By default names are built from the release name. |
| `gateway.image.repository` | `relativa-gateway` | Gateway image repository. |
| `gateway.image.tag` | `1.0.0` | Gateway image tag. Never `latest`. |
| `gateway.image.pullPolicy` | `IfNotPresent` | Pull policy, images come from `minikube image load`. |
| `gateway.replicaCount` | `1` | Gateway replicas (`3` in prod). |
| `gateway.service.type` | `NodePort` | Service type. |
| `gateway.service.port` | `8080` | Service and container port. |
| `gateway.service.nodePort` | `""` | Fixed NodePort. Empty = auto, so the chart can be installed twice. |
| `gateway.resources` | 50m / 128Mi requests, 300m / 512Mi limits | CPU and memory of the gateway container. |
| `gateway.probes.*` | `/health`, 5s/5s readiness, 15s/10s liveness | Probe path and timing. |
| `gateway.strategy.maxUnavailable`, `maxSurge` | `0`, `1` | RollingUpdate parameters. |
| `postgres.image.repository`, `postgres.image.tag` | `postgres`, `16-alpine` | Database image. |
| `postgres.replicaCount` | `1` | Database replicas. Keep it at 1: the volume is ReadWriteOnce and there is no replication. |
| `postgres.service.port` | `5432` | Database Service port. |
| `postgres.resources` | 100m / 256Mi requests, 500m / 512Mi limits | CPU and memory of the database container. |
| `postgres.pvc.enabled` | `true` | Create the PersistentVolumeClaim. When `false` the data directory is an `emptyDir`. |
| `postgres.pvc.size` | `1Gi` | Requested volume size. |
| `postgres.pvc.accessMode` | `ReadWriteOnce` | Volume access mode. |
| `postgres.pvc.storageClassName` | `""` | Storage class, empty = cluster default. |
| `config.appName` | `Relativa` | `Relativa__AppName`, shown in `/health`. |
| `config.logLevel` | `Information` | `Relativa__LogLevel`. |
| `config.jwtIssuer`, `config.jwtAudience` | `relativa-auth`, `relativa` | JWT validation parameters. |
| `config.dbName`, `config.dbUser` | `relativa` | Database name and user. |
| `secret.jwtSecretKey` | synthetic lab value | JWT signing key (Secret). Override with `--set` for anything real. |
| `secret.postgresPassword` | synthetic lab value | Database password (Secret). Override with `--set`. |
| `ingress.enabled` | `false` | Create the Ingress (`true` in prod). |
| `ingress.className`, `ingress.host`, `ingress.path`, `ingress.pathType` | `nginx`, `relativa.local`, `/`, `Prefix` | Ingress rule. |
| `ingress.annotations` | `{}` | Extra Ingress annotations. |
| `hooks.preUpgradeCheck.enabled` | `true` | Run the database check Pod before every upgrade. |
| `hooks.image.*` | `postgres:16-alpine` | Image of the hook and test Pods (has `pg_isready` and `wget`). |

## Environments

| | dev (`values-dev.yaml` / defaults) | prod (`values-prod.yaml`) |
|---|---|---|
| Gateway replicas | 1 | 3 |
| Gateway image tag | 1.0.0 | 1.1.0 |
| Gateway resources | 50m / 128Mi, limits 300m / 512Mi | 150m / 256Mi, limits 750m / 768Mi |
| Postgres resources | 100m / 256Mi, limits 500m / 512Mi | 150m / 384Mi, limits 750m / 768Mi |
| Ingress | disabled | enabled (`relativa.local`) |
| Log level | Information | Warning |

Compare them without installing anything:

```text
helm template relativa helm/ > dev.yaml
helm template relativa helm/ -f helm/values-prod.yaml > prod.yaml
git diff --no-index dev.yaml prod.yaml
```

## Secrets

No real passwords are stored in the chart. The defaults in `values.yaml` are synthetic lab strings, and `values-prod.yaml` contains no secrets at all: they are passed with `--set` at install time.

## Hook and test

- `templates/pre-upgrade-check.yaml`: `pre-upgrade` hook Pod, runs `pg_isready` against the database Service. If it fails, Helm aborts the upgrade and the running release is not touched.
- `templates/tests/test-health.yaml`: `helm test` Pod, calls `/health` of the gateway Service and expects `"status":"ok"`.
- Both Pods delete themselves on success (`hook-delete-policy`), because hook objects are not owned by the release and would otherwise survive `helm uninstall`.
