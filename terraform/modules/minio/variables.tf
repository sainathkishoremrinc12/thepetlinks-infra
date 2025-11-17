# minio module variables.tf 
variable "namespace" {
  type        = string
  description = "Namespace for MinIO deployment"
  default     = "minio"
}

variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "minio"
}

variable "repository" {
  type        = string
  description = "Helm chart repository URL"
  default     = "https://charts.bitnami.com/bitnami"
}

variable "chart" {
  type        = string
  description = "Helm chart name"
  default     = "minio"
}

variable "chart_version" {
  type        = string
  description = "MinIO chart version"
  default     = "17.0.21"
}

variable "minio_root_user" {
  type        = string
  description = "MinIO root username"
  default     = ""
}

variable "minio_root_password" {
  type        = string
  description = "MinIO root password"
  default     = ""
}

