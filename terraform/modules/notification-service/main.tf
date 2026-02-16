resource "helm_release" "notification_service" {
  name      = "notification-service"
  namespace = var.namespace
  create_namespace = true
  chart     = "../../helm-charts/notification-service"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 600

  values = [templatefile("${path.module}/values.yaml", {
    image_tag = var.image_tag
    db_user   = var.db_user
    db_pass   = var.db_password
  })]
}
