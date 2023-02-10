locals {
  ami_id = length(var.ami_id) > 0 ? var.ami_id : data.aws_ami.eks_default.id
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                   = var.stack
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true
  create_cluster_security_group = false
  cluster_security_group_id = aws_security_group.cluster_security_group.id
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

  vpc_id                   = data.aws_vpc.vpc.id
  subnet_ids               = data.aws_subnet_ids.node_subnets.ids
  control_plane_subnet_ids = data.aws_subnet_ids.control_plane_subnets.ids

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    },
    ingress_source_security_group_id = {
      description = "NLB healthcheck"
      protocol    = "tcp"
      to_port     = var.ingress_node_port
      from_port   = var.ingress_node_port
      type        = "ingress"
      cidr_blocks = [data.aws_vpc.vpc.cidr_block]
    }
  }

  eks_managed_node_group_defaults = {
    ami_id                     = local.ami_id
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
        EC2CreateVolume                    = aws_iam_policy.ebs_csi_policy.arn
      }
    }
  }

  tags = {
    stack     = var.stack
    managedBy = "terraform"
  }
}
