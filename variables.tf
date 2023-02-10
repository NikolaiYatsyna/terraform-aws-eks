variable "region" {}

variable "stack" {
  description = "stack name"
}

variable "cluster_version" {
  description = "Amazon EKS Kubernetes version"
  default     = "1.24"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t3.micro"
}

variable "nodegroup_min_size" {
  description = "Nodegroup min size"
  default     = "10"
}

variable "nodegroup_max_size" {
  description = "Nodegroup max size"
  default     = "10"
}

variable "nodegroup_desired_size" {
  description = "Nodegroup desired size"
  default     = "10"
}

variable "ami_id" {
  description = "ami id for node group"
  default     = ""
}

variable "private_subnet_tags" {
  description = "A map of additional tags to add to the private subnets"
  type        = map(string)
}

variable "intra_subnet_tags" {
  description = "A map of additional tags to add to the intra subnets"
  type        = map(string)
}

variable "ingress_node_port" {
  description = "Node port of nginx ingress for NLB to proxy traffic to"
}
