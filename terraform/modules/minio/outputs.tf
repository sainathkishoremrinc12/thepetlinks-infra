# minio module outputs.tf 
output "console_url" {
  value = "http://${var.console_host}"
}

output "service_name" {
  value = kubernetes_service.minio.metadata[0].name
}
