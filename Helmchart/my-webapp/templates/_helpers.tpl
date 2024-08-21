{{/* Generate a name for the resources based on the release name and chart name */}}
{{- define "my-webapp.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name -}}
{{- end -}}
