module "alb" {
  depends_on = [module.eks]
  source     = "terraform-aws-modules/alb/aws"
  version    = "~> 8.0"

  name                 = var.stack
  load_balancer_type   = "network"
  vpc_id               = var.vpc_id
  subnets              = var.lb_subnets
  preserve_host_header = true

  https_listeners = [
    {
      port               = 443
      protocol           = "TLS"
      certificate_arn    = var.cert_arn
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name             = "${var.stack}-ingress-tg-https"
      backend_protocol = "TCP"
      backend_port     = local.nginx_ingress_node_port
      vpc_id           = var.vpc_id
    }
  ]
}

resource "kubernetes_manifest" "ingress-binding" {
  depends_on = [helm_release.nginx_ingress_controller, helm_release.aws_lb_controller, module.alb]
  manifest = {
    "apiVersion" = "elbv2.k8s.aws/v1beta1"
    "kind"       = "TargetGroupBinding"

    metadata = {
      name      = "ingress-binding"
      namespace = local.nginx_ingress_namespace
    }
    "spec" = {
      "serviceRef" = {
        "name" = data.kubernetes_service.nginx_ingress_service.metadata[0].name
        "port" = 80
      }
      "targetGroupARN" = data.aws_lb_target_group.ingress-tg-https.arn
    }
  }
}