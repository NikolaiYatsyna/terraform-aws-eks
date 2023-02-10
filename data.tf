data "aws_ami" "eks_default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-v*"]
  }
}

data "aws_vpc" "vpc" {
  name = "${var.stack}-vpc"
}

data "aws_subnet_ids" "node_subnets" {
  vpc_id = data.aws_vpc.vpc.id
  tags = var.private_subnet_tags
}

data "aws_subnet_ids" "control_plane_subnets" {
  vpc_id = data.aws_vpc.vpc.id
  tags = var.intra_subnet_tags
}
