# kafka module variables.tf 

variable "namespace" {
  description = "Namespace for Redpanda"
  type        = string
}

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}
