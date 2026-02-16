resource "helm_release" "mail_service" {
  name      = "mail-service"
  namespace = var.namespace
  create_namespace = true
  chart     = "../../helm-charts/mail-service"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 600

  values = [templatefile("${path.module}/values.yaml", {
    image_tag = var.image_tag
    db_user   = var.db_user
    db_pass   = var.db_password
  })]
}
