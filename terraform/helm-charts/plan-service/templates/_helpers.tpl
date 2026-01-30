{{- define "plan-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "plan-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "plan-service.labels" -}}
app.kubernetes.io/name: {{ include "plan-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
