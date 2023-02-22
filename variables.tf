variable "stack" {
  type = string
  description = "stack name"
}

variable "cluster_version" {
  type = string
  description = "Amazon EKS Kubernetes version"
  default     = "1.24"
}

variable "instance_type" {
  type = string
  description = "Instance type"
  default     = "t3.micro"
}

variable "nodegroup_min_size" {
  type = string
  description = "Nodegroup min size"
  default     = "10"
}

variable "nodegroup_max_size" {
  type = string
  description = "Nodegroup max size"
  default     = "10"
}

variable "nodegroup_desired_size" {
  type = string
  description = "Nodegroup desired size"
  default     = "10"
}

variable "ami_id" {
  type = string
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