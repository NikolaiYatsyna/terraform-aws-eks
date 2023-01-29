resource "helm_release" "aws_lb_controller" {
  name              = "aws-load-balancer-controller"
  repository        = "https://aws.github.io/eks-charts"
  chart             = "aws-load-balancer-controller"
  namespace         = "kube-system"
  atomic            = true
  dependency_update = true
  verify            = false

  depends_on = [
    kubernetes_service_account.service-account
  ]

  values = [
    yamlencode({
      clusterName = var.stack
      region      = var.region,
      vpcId       = var.vpc_id,
      image = {
        repository = "602401143452.dkr.ecr.${var.region}.amazonaws.com/amazon/aws-load-balancer-controller"
      }
      serviceAccount = {
        create = false
        name   = kubernetes_service_account.service-account.metadata[0].name
      }
      defaultTags = {
        stack     = var.stack
        managedBy = "terraform"
      }
    })
  ]
}