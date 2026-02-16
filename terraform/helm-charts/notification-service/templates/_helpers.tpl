{{- define "notification-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "notification-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "notification-service.labels" -}}
app.kubernetes.io/name: {{ include "notification-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
