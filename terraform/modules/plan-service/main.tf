resource "helm_release" "plan_service" {
  name      = "plan-service"
  namespace = var.namespace
  create_namespace = true
  chart     = "../../helm-charts/plan-service"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 300

  values = [templatefile("${path.module}/values.yaml", {
    image_tag = var.image_tag
    db_user   = var.db_user
    db_pass   = var.db_password
  })]
}
