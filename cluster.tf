module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "20.31.3"
  cluster_name                             = var.cluster_name != null ? var.cluster_name : "${var.stack}-eks"
  cluster_endpoint_public_access           = true
  create_cluster_security_group            = true
  cluster_security_group_name              = "${var.stack}-eks-sg"
  cluster_security_group_use_name_prefix   = false
  enable_cluster_creator_admin_permissions = true
  cluster_addons = {
    coredns = {
      preserve    = true
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.intra_subnet_ids

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  eks_managed_node_group_defaults = {
    instance_types             = [var.instance_type]
    min_size                   = var.nodegroup_min_size
    max_size                   = var.nodegroup_max_size
    desired_size               = var.nodegroup_desired_size
    use_custom_launch_template = false
    force_update_version       = true
    enable_bootstrap_user_data = true
    bootstrap_extra_args       = "--container-runtime containerd --kubelet-extra-args '--max-pods=50'"
    pre_bootstrap_user_data    = <<-EOT
          export CONTAINER_RUNTIME="containerd"
          export USE_MAX_PODS=false
          sudo systemctl enable amazon-ssm-agent
          sudo systemctl start amazon-ssm-agent
        EOT
  }

  eks_managed_node_groups = {
    default_group = {
      name = "default-node-group"

      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        AmazonSSMManagedInstanceCore       = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        AmazonEC2RoleforSSM                = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        EC2CreateVolume                    = aws_iam_policy.eks-node-policy.arn
      }
    }
  }

  tags = var.tags
}

resource "aws_ec2_tag" "private_subnet_tag" {
  for_each    = toset(var.private_subnet_ids)
  resource_id = each.key
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

resource "aws_ec2_tag" "public_subnet_tag" {
  for_each    = toset(var.public_subnet_ids)
  resource_id = each.key
  key         = "kubernetes.io/role/elb"
  value       = "1"
}
