variable "namespace" {
  type        = string
  description = "Kafka namespace"
}

variable "release_name" {
  type        = string
  description = "Helm release name"
}

variable "replica_count" {
  type    = number
  default = 3
}

variable "storage_size" {
  type    = string
  default = "20Gi"
}

variable "storage_class" {
  type    = string
  default = "standard"
}

variable "zookeeper_enabled" {
  type    = bool
  default = true
}
