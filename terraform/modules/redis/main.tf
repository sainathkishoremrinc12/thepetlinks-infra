resource "kubernetes_namespace" "redis" {
  metadata {
    name = "redis"
  }
}

resource "helm_release" "redis" {
  name       = "redis"
  chart      = "bitnami/redis"
  version    = "23.2.12"
  namespace  = "redis"

  values = [
    yamlencode({
      architecture = "standalone"
      auth = {
        enabled  = true
        password = var.redis_password
      }
      master = {
        persistence = {
          enabled = true
          size    = "5Gi"
        }
      }
      service = {
        type = "ClusterIP"
        port = 6379
      }
    })
  ]
}
