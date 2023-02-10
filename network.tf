resource "aws_security_group" "cluster_security_group" {
  name        = "${var.stack}-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_security_group_rule" "nlb_healthcheck_rule" {
  from_port         = var.ingress_node_port
  protocol          = "-1"
  security_group_id = aws_security_group.cluster_security_group.id
  self              = true
  to_port           = var.ingress_node_port
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_api_rule" {
  security_group_id = aws_security_group.cluster_security_group.id
  description       = "Node groups to cluster API"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  type              = "ingress"
  self              = true
}
