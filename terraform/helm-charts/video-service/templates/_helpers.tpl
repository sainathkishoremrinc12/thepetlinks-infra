{{- define "video-service.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "video-service.fullname" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "video-service.labels" -}}
app.kubernetes.io/name: {{ include "video-service.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
