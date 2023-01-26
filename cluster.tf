data "aws_ami" "eks_default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-v*"]
  }
}

locals {
  ami_id = length(var.ami_id) > 0 ? var.ami_id : data.aws_ami.eks_default.id
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true

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
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.node_subnets
  control_plane_subnet_ids = var.control_plane_subnets

  eks_managed_node_group_defaults = {
    ami_id                     = local.ami_id
    instance_types             = [var.instance_type]
    min_size                   = var.nodegroup_min_size
    max_size                   = var.nodegroup_max_size
    desired_size               = var.nodegroup_desired_size
    use_custom_launch_template = false
    force_update_version       = true
    enable_bootstrap_user_data = true
    bootstrap_extra_args       = "--container-runtime containerd --kubelet-extra-args '--max-pods=20'"
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
        AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      }
    }
  }
}