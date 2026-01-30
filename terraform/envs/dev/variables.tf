# Environment
variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)"
  type        = string
  default     = "dev"
}

# 🐘 PostgreSQL
variable "postgres_user_password" {
  description = "App-level Postgres user password"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "Root Postgres password"
  type        = string
  sensitive   = true
}

# 🧠 Redis
variable "redis_password" {
  description = "Redis authentication password"
  type        = string
  sensitive   = true
}

# 🦋 Kafka
variable "kafka_user" {
  description = "Kafka SASL username"
  type        = string
}

variable "kafka_password" {
  description = "Kafka SASL password"
  type        = string
  sensitive   = true
}

variable "enable_sasl_auth" {
  description = "Enable SASL authentication for Kafka"
  type        = bool
  default     = false
}

# 🪣 MinIO
variable "minio_root_user" {
  description = "MinIO root username"
  type        = string
}

variable "minio_root_password" {
  description = "MinIO root password"
  type        = string
  sensitive   = true
}

variable "db_user" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}
