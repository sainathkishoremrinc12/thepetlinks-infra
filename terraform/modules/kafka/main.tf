resource "kubernetes_namespace" "kafka" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "kafka" {
  name             = var.release_name
  chart            = "${path.module}/charts/kafka"
  namespace        = var.namespace
  create_namespace = true

  dependency_update = false

  wait    = true
  atomic  = true
  timeout = 600

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.kafka
  ]
}
