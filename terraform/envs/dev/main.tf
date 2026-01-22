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
  source              = "../../modules/minio"
  minio_root_user     = var.minio_root_user
  minio_root_password = var.minio_root_password
}

# 🦋 Kafka Module
module "kafka" {
  source        = "../../modules/kafka"
  namespace     = "kafka"
  release_name  = "kafka"
}

# Role Module
module "role_service" {
  source      = "../../modules/role-service"
  namespace   = "petlinks-dev"
  image_tag   = "latest"
  db_user     = var.db_user
  db_password = var.db_password
}
