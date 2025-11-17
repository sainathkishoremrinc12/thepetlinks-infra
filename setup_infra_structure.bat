@echo off
title 🚀 ThePetLinks Infra Auto Setup
echo ======================================
echo  🌐 Mr. Intelligence Inc. - Infra Setup
echo ======================================

REM ROOT STRUCTURE
mkdir thepetlinks-infra
cd thepetlinks-infra

echo # ThePetLinks Infrastructure Repository > README.md
echo target/ > .gitignore
echo MIT License - Mr. Intelligence Inc. > LICENSE

REM ─────────────── TERRAFORM ───────────────
mkdir terraform
cd terraform

echo terraform { required_version = ">=1.5.0" } > versions.tf
(
echo terraform {
echo   required_providers {
echo     kubernetes = { source = "hashicorp/kubernetes" version = "~> 2.30" }
echo     helm       = { source = "hashicorp/helm" version = "~> 2.13" }
echo   }
echo }
echo provider "kubernetes" { config_path = "~/.kube/config" }
echo provider "helm" { kubernetes { config_path = "~/.kube/config" } }
) > providers.tf
echo region = "local" > terraform.tfvars
echo # Terraform Infrastructure as Code > README.md

REM env folders
mkdir envs
mkdir envs\dev envs\staging envs\prod
for %%e in (dev staging prod) do (
    echo variable "environment" { default = "%%e" } > envs\%%e\variables.tf
    echo output "cluster_endpoint" { value = "localhost" } > envs\%%e\outputs.tf
    echo # main.tf for %%e environment > envs\%%e\main.tf
    echo terraform { backend "local" { path = "../../state/%%e.tfstate" } } > envs\%%e\backend.tf
)

REM modules
mkdir modules
for %%m in (kubernetes postgresql redis kafka minio jenkins argocd prometheus grafana nginx-ingress) do (
    mkdir modules\%%m
    echo # %%m module main.tf > modules\%%m\main.tf
    echo # %%m module variables.tf > modules\%%m\variables.tf
    echo # %%m module outputs.tf > modules\%%m\outputs.tf
)

cd ..
REM ─────────────── HELM ───────────────
mkdir helm
cd helm
for %%s in (gateway auth-service role-service pet-service docs-service payment-service review-service notification-service client admin monitoring argocd jenkins) do (
    mkdir %%s
    echo apiVersion: v2 > %%s\Chart.yaml
    echo name: %%s >> %%s\Chart.yaml
    echo version: 0.1.0 >> %%s\Chart.yaml
    echo # Default Helm values for %%s > %%s\values.yaml
    mkdir %%s\templates
    echo # Kubernetes deployment templates > %%s\templates\README.md
)

REM AI services
mkdir ai-services
for %%a in (ai-verification ai-recommendation ai-voice ai-learning ai-insight) do (
    mkdir ai-services\%%a
    echo apiVersion: v2 > ai-services\%%a\Chart.yaml
    echo name: %%a >> ai-services\%%a\Chart.yaml
    echo version: 0.1.0 >> ai-services\%%a\Chart.yaml
    echo # Default values > ai-services\%%a\values.yaml
    mkdir ai-services\%%a\templates
    echo # Kubernetes deployment templates > ai-services\%%a\templates\README.md
)

cd ..
REM ─────────────── ARGOCD ───────────────
mkdir argocd
mkdir argocd\apps argocd\projects
(
echo apiVersion: argoproj.io/v1alpha1
echo kind: AppProject
echo metadata:
echo ^  name: thepetlinks
echo spec:
echo ^  description: ThePetLinks Project
echo ^  sourceRepos:
echo ^    - https://github.com/ThePetLinks/*
echo ^  destinations:
echo ^    - namespace: '*'
echo ^      server: https://kubernetes.default.svc
) > argocd\projects\thepetlinks-project.yaml

(
echo apiVersion: argoproj.io/v1alpha1
echo kind: Application
echo metadata:
echo ^  name: gateway-app
echo spec:
echo ^  project: thepetlinks
echo ^  source:
echo ^    repoURL: https://github.com/ThePetLinks/thepetlinks-infra
echo ^    path: helm/gateway
echo ^  destination:
echo ^    server: https://kubernetes.default.svc
echo ^    namespace: gateway
echo ^  syncPolicy:
echo ^    automated:
echo ^      prune: true
echo ^      selfHeal: true
) > argocd\apps\gateway-app.yaml

echo # ArgoCD Values Config > argocd\argocd-values.yaml

REM ─────────────── MONITORING ───────────────
mkdir monitoring
mkdir monitoring\grafana-dashboards
echo global: > monitoring\prometheus.yaml
echo # Prometheus Config > monitoring\prometheus.yaml
echo route: > monitoring\alertmanager.yaml
echo # Grafana Dashboards > monitoring\grafana-dashboards\README.md

REM ─────────────── JENKINS ───────────────
mkdir jenkins
mkdir jenkins\pipelines jenkins\pipelines\shared-libs
echo FROM jenkins/jenkins:lts > jenkins\Dockerfile
echo # Jenkins K8s deployment YAML > jenkins\jenkins.yaml
echo # Jenkins pipeline template > jenkins\pipelines\Jenkinsfile-template.groovy
echo # Jenkins Setup > jenkins\README.md

REM ─────────────── SCRIPTS ───────────────
mkdir scripts
(
echo @echo off
echo echo Setting up ThePetLinks Infra...
echo REM This script auto-creates folders and base files
) > scripts\setup_infra.bat

(
echo #!/bin/bash
echo echo "🐧 Setting up infra folders on Linux..."
) > scripts\setup_infra.sh

(
echo #!/bin/bash
echo pg_dump thepetlinks_db > backup.sql
) > scripts\backup_db.sh

(
echo #!/bin/bash
echo psql thepetlinks_db < backup.sql
) > scripts\restore_db.sh

(
echo #!/bin/bash
echo echo "Deploying all Helm charts..."
) > scripts\deploy_all.sh

REM ─────────────── SECRETS ───────────────
mkdir secrets
echo apiVersion: v1 > secrets\db-secrets.yaml
echo kind: Secret >> secrets\db-secrets.yaml
echo metadata: >> secrets\db-secrets.yaml
echo ^  name: db-secret >> secrets\db-secrets.yaml
echo # Redis secret > secrets\redis-secrets.yaml
echo # JWT secret > secrets\jwt-secret.yaml

cd ..

echo ✅ All folders and files created successfully!
pause
