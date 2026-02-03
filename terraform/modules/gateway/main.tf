resource "helm_release" "gateway" {
  name      = "gateway"
  namespace = var.namespace
  create_namespace = true
  chart     = "../../helm-charts/gateway"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 300

  values = [templatefile("${path.module}/values.yaml", {
    image_tag = var.image_tag
    db_user   = var.db_user
    db_pass   = var.db_password
  })]
}
