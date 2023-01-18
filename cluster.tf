module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnets
  cluster_endpoint_private_access = true
  manage_aws_auth_configmap = true

  eks_managed_node_group_defaults = {
    attach_cluster_primary_security_group = true
    create_security_group = true
    iam_role_attach_cni_policy = true
  }

  eks_managed_node_groups = {

    default_node_group = {
      use_custom_launch_template = false
      name = var.cluster_name
      instance_types = [var.instance_type]

      min_size     = var.nodegroup_min_size
      max_size     = var.nodegroup_max_size
      desired_size = var.nodegroup_desired_size
    }
  }
}