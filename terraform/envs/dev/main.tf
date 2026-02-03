terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.30.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.14.1" # ✅ only one version, no comma
    }
  }
}

# 🧠 Kubernetes & Helm Provider
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# 🐘 PostgreSQL Module
module "postgresql" {
  source = "../../modules/postgresql"
  postgres_user          = "thepetlinks"
  postgres_user_password = var.postgres_user_password
  postgres_password      = var.postgres_password
  postgres_database      = "thepetlinksdb"
}

# 🧠 Redis Module
module "redis" {
  source         = "../../modules/redis"
  redis_password = var.redis_password
}

# 🪣 MinIO Module
module "minio" {
  source = "../../modules/minio"

  namespace       = "minio"
  root_user       = "admin"
  root_password   = "MrInc@2018$PeT"
  storage_size    = "10Gi"
  console_host    = "minio-console.petlinks.local"
}

# Role Module
module "role_service" {
  source      = "../../modules/role-service"
  namespace   = "petlinks-dev"
  image_tag   = "latest"
  db_user     = var.db_user
  db_password = var.db_password
}

# Auth Module
module "auth_service" {
  source      = "../../modules/auth-service"
  namespace   = "petlinks-dev"
  image_tag   = "latest"
  db_user     = var.db_user
  db_password = var.db_password
}

# Plan Module
module "plan_service" {
  source      = "../../modules/plan-service"
  namespace   = "petlinks-dev"
  image_tag   = "latest"
  db_user     = var.db_user
  db_password = var.db_password
}

# master Module
module "master_service" {
  source      = "../../modules/master-service"
  namespace   = "petlinks-dev"
  image_tag   = "latest"
  db_user     = var.db_user
  db_password = var.db_password
}

# gateway Module
module "gateway" {
  source      = "../../modules/gateway"
  namespace   = "petlinks-dev"
  image_tag   = "latest"
  db_user     = var.db_user
  db_password = var.db_password
}

# docs Module
module "docs_service" {
  source      = "../../modules/docs-service"
  namespace   = "petlinks-dev"
  image_tag   = "latest"
  db_user     = var.db_user
  db_password = var.db_password
}
