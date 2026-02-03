# PVC (v1)
resource "kubernetes_persistent_volume_claim_v1" "minio" {
  wait_until_bound = false   # 🔥 THIS is the fix

  metadata {
    name      = "minio"
    namespace = var.namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = var.storage_size
      }
    }
  }
}

# Deployment
resource "kubernetes_deployment" "minio" {
  metadata {
    name      = "minio"
    namespace = var.namespace
    labels = {
      app = "minio"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "minio"
      }
    }

    template {
      metadata {
        labels = {
          app = "minio"
        }
      }

      spec {
        container {
          name  = "minio"
          image = "minio/minio:RELEASE.2025-07-18T21-56-31Z"

          args = [
            "server",
            "/data",
            "--console-address",
            ":9001"
          ]

          env {
            name  = "MINIO_ROOT_USER"
            value = var.root_user
          }

          env {
            name  = "MINIO_ROOT_PASSWORD"
            value = var.root_password
          }

          env {
            name  = "MINIO_BROWSER_REDIRECT_URL"
            value = "http://minio-console.petlinks.local"
          }

          port {
            name           = "api"
            container_port = 9000
          }

          port {
            name           = "console"
            container_port = 9001
          }

          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }

        volume {
          name = "data"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.minio.metadata[0].name
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service" "minio" {
  metadata {
    name      = "minio"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "minio"
    }

    port {
      name        = "api"
      port        = 9000
      target_port = 9000
    }

    port {
      name        = "console"
      port        = 9001
      target_port = 9001
    }

    type = "ClusterIP"
  }
}
