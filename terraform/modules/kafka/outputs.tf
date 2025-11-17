# kafka module outputs.tf 
output "namespace" {
  description = "Namespace where Redpanda is deployed"
  value       = kubernetes_namespace.redpanda.metadata[0].name
}

output "release_name" {
  description = "Helm release name of Redpanda"
  value       = var.release_name
}

output "redpanda_console_url" {
  description = "URL to access Redpanda Console (via port-forward)"
  value       = "http://localhost:8080"
}

