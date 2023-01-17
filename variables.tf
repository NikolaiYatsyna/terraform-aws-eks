variable "cluster_name" {
  description = "Name of EKS cluster"
  default = "test"
}

variable "cluster_version" {
  description = "Amazon EKS Kubernetes version"
  default = "1.24"
}

variable "instance_type" {
  description = "Instance type"
  default = "t3.micro"
}

variable "nodegroup_min_size" {
  description = "Nodegroup min size"
  default = "1"
}

variable "nodegroup_max_size" {
  description = "Nodegroup max size"
  default = "1"
}
variable "nodegroup_desired_size" {
  description = "Nodegroup desired size"
  default = "1"
}

variable "vpc_id" {
  description = "VPC id to use"
}

variable "subnets" {
  description = "Subnets ids"
  type = list(string)
}