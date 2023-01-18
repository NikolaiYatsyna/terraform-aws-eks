module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnets
  cluster_endpoint_private_access = true
  manage_aws_auth_configmap       = true
  create_cni_ipv6_iam_policy      = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent              = true
      service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
      configuration_values = jsonencode({
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  eks_managed_node_group_defaults = {
    attach_cluster_primary_security_group = true
    create_security_group                 = true
    iam_role_attach_cni_policy            = true

  }

  eks_managed_node_groups = {
    default_node_group = {
      use_custom_launch_template = false
      name                       = var.cluster_name
      instance_types             = [var.instance_type]

      min_size     = var.nodegroup_min_size
      max_size     = var.nodegroup_max_size
      desired_size = var.nodegroup_desired_size
    }
  }
}

module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix      = "VPC-CNI-IRSA"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv6   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }
}