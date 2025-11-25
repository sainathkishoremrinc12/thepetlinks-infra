{{- define "role-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "role-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "role-service.labels" -}}
app.kubernetes.io/name: {{ include "role-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
