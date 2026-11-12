{{/*
Chart name, truncated to the 63 characters Kubernetes allows for names.
*/}}
{{- define "relativa.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Full object name built from the RELEASE name, so the chart can be installed
several times into one cluster. If the release name already contains the chart
name ("relativa"), it is not repeated.
*/}}
{{- define "relativa.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Chart label value: name and version.
*/}}
{{- define "relativa.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels. Used in Deployment selectors and Service selectors, so they must
stay stable: the selector of a Deployment cannot be changed after creation.
Call: include "relativa.selectorLabels" (dict "ctx" . "component" "gateway")
*/}}
{{- define "relativa.selectorLabels" -}}
app.kubernetes.io/name: {{ include "relativa.name" .ctx }}
app.kubernetes.io/instance: {{ .ctx.Release.Name }}
app.kubernetes.io/component: {{ .component }}
{{- end }}

{{/*
Common label set (selector labels + chart metadata).
Call: include "relativa.labels" (dict "ctx" . "component" "gateway")
*/}}
{{- define "relativa.labels" -}}
helm.sh/chart: {{ include "relativa.chart" .ctx }}
{{ include "relativa.selectorLabels" . }}
app.kubernetes.io/version: {{ .ctx.Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .ctx.Release.Service }}
{{- end }}
