resource "kubernetes_namespace" "role_service_ns" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "role_service" {
  name       = "role-service"
  namespace  = kubernetes_namespace.role_service_ns.metadata[0].name
  chart      = "../../helm-charts/role-service"

  atomic           = true
  cleanup_on_fail  = true
  timeout          = 300

  values     = [templatefile("${path.module}/values.yaml", {
    image_tag = var.image_tag
    db_user   = var.db_user
    db_pass   = var.db_password
  })]

  depends_on = [
    kubernetes_namespace.role_service_ns
  ]
}
