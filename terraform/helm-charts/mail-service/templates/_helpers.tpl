{{- define "mail-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "mail-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "mail-service.labels" -}}
app.kubernetes.io/name: {{ include "mail-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
