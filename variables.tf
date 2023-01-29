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

variable "vpc_id" {
  description = "VPC id to use"
}

variable "node_subnets" {
  description = "Subnets ids for nodes"
  type        = list(string)
}

variable "control_plane_subnets" {
  description = "Subnets ids for control plance"
  type        = list(string)
}

variable "lb_subnets" {
  description = "Public subnets for LB"
  type        = list(string)
}

variable "cert_arn" {
  description = "SSL cert arn"
}