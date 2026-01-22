# kafka module outputs.tf

output "namespace" {
  value = var.namespace
}

output "release_name" {
  value = var.release_name
}

output "bootstrap_servers" {
  value = "kafka.${var.namespace}.svc.cluster.local:9092"
}
