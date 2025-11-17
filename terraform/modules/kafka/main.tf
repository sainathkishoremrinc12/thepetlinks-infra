resource "kubernetes_namespace" "redpanda" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "redpanda" {
  name       = var.release_name
  namespace  = kubernetes_namespace.redpanda.metadata[0].name

  repository = "https://charts.redpanda.com"
  chart      = "redpanda"
  version    = "5.9.10"

  values = [
    file("${path.module}/values.yaml")
  ]
}
