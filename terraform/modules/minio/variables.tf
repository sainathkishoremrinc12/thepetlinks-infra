variable "namespace" {
  description = "Namespace for MinIO"
  type        = string
  default     = "minio"
}

variable "root_user" {
  description = "MinIO root user"
  type        = string
}

variable "root_password" {
  description = "MinIO root password"
  type        = string
  sensitive   = true
}

variable "storage_size" {
  description = "PVC storage size"
  type        = string
  default     = "10Gi"
}

variable "console_host" {
  description = "Ingress host for MinIO console"
  type        = string
}
