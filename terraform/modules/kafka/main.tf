resource "helm_release" "kafka" {
  name       = var.release_name
  namespace  = var.namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  version    = "26.8.5"

  create_namespace = true

  values = [
    yamlencode({
      kraft = {
        enabled = false
      }

      zookeeper = {
        enabled = true
      }

      controller = {
        replicaCount = 0
      }

      broker = {
        replicaCount = 3
      }

      persistence = {
        enabled      = true
        size         = var.storage_size
        storageClass = var.storage_class
      }

      listeners = {
        client = {
          protocol = "PLAINTEXT"
        }
      }

      auth = {
        enabled = false
      }
    })
  ]
}
