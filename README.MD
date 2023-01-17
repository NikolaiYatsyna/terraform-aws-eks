## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | AMI to use for nodegroup | `string` | `"ami-06acc29adf84c8f3c"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS cluster | `string` | `"test"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Amazon EKS Kubernetes version | `string` | `"1.23"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t3.micro"` | no |
| <a name="input_nodegroup_desired_size"></a> [nodegroup\_desired\_size](#input\_nodegroup\_desired\_size) | Nodegroup desired size | `string` | `"1"` | no |
| <a name="input_nodegroup_max_size"></a> [nodegroup\_max\_size](#input\_nodegroup\_max\_size) | Nodegroup max size | `string` | `"1"` | no |
| <a name="input_nodegroup_min_size"></a> [nodegroup\_min\_size](#input\_nodegroup\_min\_size) | Nodegroup min size | `string` | `"1"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to run in | `string` | `"us-east-2"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets ids | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id to use | `any` | n/a | yes |

## Outputs

No outputs.
