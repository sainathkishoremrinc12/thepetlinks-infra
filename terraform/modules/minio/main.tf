resource "kubernetes_namespace" "minio" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "minio" {
  name       = var.release_name
  repository = "https://charts.min.io"
  chart      = "minio"
  version    = "5.4.0" # ✅ confirmed latest available stable version
  namespace  = kubernetes_namespace.minio.metadata[0].name

  values = [
    yamlencode({
      image = {
        repository = "quay.io/minio/minio"
        tag        = "RELEASE.2025-09-07T16-13-09Z-cpuv1" # ✅ working tag
        pullPolicy = "IfNotPresent"
      }

      rootUser     = var.minio_root_user
      rootPassword = var.minio_root_password

      mode = "standalone"

      persistence = {
        enabled = true
        size    = "10Gi"
      }

      resources = {
        requests = {
          memory = "512Mi"
          cpu    = "250m"
        }
        limits = {
          memory = "1Gi"
          cpu    = "500m"
        }
      }
    })
  ]
}
