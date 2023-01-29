data "aws_lb_target_group" "ingress-tg-https" {
  depends_on = [module.alb]
  name       = "${var.stack}-ingress-tg-https"
}

data "kubernetes_service" "nginx_ingress_service" {
  depends_on = [helm_release.nginx_ingress_controller]
  metadata {
    name      = "${local.nginx_ingress_name}-controller"
    namespace = "kube-system"
  }
}

data "aws_ami" "eks_default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-v*"]
  }
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}
