#!/bin/bash

# Create directory for the Helm chart
mkdir my-webapp

# Create Chart.yaml file
cat << EOF > my-webapp/Chart.yaml
apiVersion: v2
name: my-webapp
description: A Helm chart for deploying a simple web application
version: 0.1.0
EOF

# Create values.yaml file
cat << EOF > my-webapp/values.yaml
# Default values for my-webapp.
replicaCount: 1
image:
  repository: nginx
  tag: stable
  pullPolicy: IfNotPresent
service:
  type: ClusterIP
  port: 80
EOF

# Create templates directory
mkdir my-webapp/templates

# Create deployment.yaml file
cat << EOF > my-webapp/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "my-webapp.fullname" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: my-webapp
  template:
    metadata:
      labels:
        app: my-webapp
    spec:
      containers:
        - name: my-webapp
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: 80
EOF

# Create service.yaml file
cat << EOF > my-webapp/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "my-webapp.fullname" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: 80
  selector:
    app: my-webapp
EOF

# Create _helpers.tpl file
cat << EOF > my-webapp/templates/_helpers.tpl
{{/* Generate a name for the resources based on the release name and chart name */}}
{{- define "my-webapp.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name -}}
{{- end -}}
EOF

echo "Helm chart files created successfully in my-webapp directory."
