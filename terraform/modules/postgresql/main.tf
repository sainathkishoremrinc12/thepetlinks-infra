resource "helm_release" "postgresql" {
  name             = "postgresql"
  chart            = "${path.module}/charts/postgresql"
  namespace        = "postgresql"
  create_namespace = true

  wait    = true
  atomic = true
  timeout = 600

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
