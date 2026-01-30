resource "kubernetes_namespace" "redis" {
  metadata {
    name = "redis"
  }
}

resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "19.5.2"
  namespace  = kubernetes_namespace.redis.metadata[0].name

  values = [
    yamlencode({
      architecture = "standalone"

      image = {
        registry   = "docker.io"
        repository = "bitnamilegacy/redis"
        tag        = "7.2.5" # Explicitly use r2 or later
        pullPolicy = "Always"
      }

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
    })
  ]
}
