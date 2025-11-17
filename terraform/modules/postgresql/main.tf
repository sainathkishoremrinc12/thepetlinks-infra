resource "helm_release" "postgresql" {
  name       = "postgresql"
  chart      = "bitnami/postgresql"
  version    = "18.1.9"
  namespace  = "postgresql"

  values = [
    yamlencode({
      global = {
        postgresql = {
          auth = {
            postgresPassword = var.postgres_password
            username         = var.postgres_user
            password         = var.postgres_user_password
            database         = var.postgres_database
          }
        }
      }
      primary = {
        persistence = {
          enabled = true
          size    = "10Gi"
        }
      }
      service = {
        type = "ClusterIP"
        port = 5432
      }
    })
  ]
}
