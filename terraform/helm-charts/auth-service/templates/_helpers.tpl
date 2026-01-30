{{- define "auth-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "auth-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "auth-service.labels" -}}
app.kubernetes.io/name: {{ include "auth-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
