{{- define "customer-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "customer-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "customer-service.labels" -}}
app.kubernetes.io/name: {{ include "customer-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
