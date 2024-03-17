variable "stack" {
  type        = string
  description = "stack name"
}

variable "cluster_version" {
  type        = string
  description = "Amazon EKS Kubernetes version"
  default     = "1.29"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t3.micro"
}

variable "nodegroup_min_size" {
  type        = string
  description = "Nodegroup min size"
  default     = "10"
}

variable "nodegroup_max_size" {
  type        = string
  description = "Nodegroup max size"
  default     = "10"
}

variable "nodegroup_desired_size" {
  type        = string
  description = "Nodegroup desired size"
  default     = "10"
}

variable "ami_id" {
  type        = string
  description = "ami id for node group"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "ID of AWS VPC"
}

variable "public_subnet_ids" {
  description = "IDs of public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs of private subnets"
  type        = list(string)
}

variable "intra_subnet_ids" {
  description = "IDs of intra subnets"
  type        = list(string)
}


variable "tags" {
  description = "A map of additional tags to add to the vpc"
  type        = map(string)
  default     = {}
}
