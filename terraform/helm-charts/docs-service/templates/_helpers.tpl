{{- define "docs-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "docs-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "docs-service.labels" -}}
app.kubernetes.io/name: {{ include "docs-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
