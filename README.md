## Introduction
Terraform module to provision EKS cluster in AWS

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.40.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | 2.3.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.17.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.11.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 20.8.3 |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.private_subnet_tag](https://registry.terraform.io/providers/hashicorp/aws/5.40.0/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.public_subnet_tag](https://registry.terraform.io/providers/hashicorp/aws/5.40.0/docs/resources/ec2_tag) | resource |
| [aws_iam_policy.eks-node-policy](https://registry.terraform.io/providers/hashicorp/aws/5.40.0/docs/resources/iam_policy) | resource |
| [aws_ami.eks_default](https://registry.terraform.io/providers/hashicorp/aws/5.40.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ami id for node group | `string` | `""` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Amazon EKS Kubernetes version | `string` | `"1.25"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t3.micro"` | no |
| <a name="input_intra_subnet_ids"></a> [intra\_subnet\_ids](#input\_intra\_subnet\_ids) | IDs of intra subnets | `list(string)` | n/a | yes |
| <a name="input_nodegroup_desired_size"></a> [nodegroup\_desired\_size](#input\_nodegroup\_desired\_size) | Nodegroup desired size | `string` | `"10"` | no |
| <a name="input_nodegroup_max_size"></a> [nodegroup\_max\_size](#input\_nodegroup\_max\_size) | Nodegroup max size | `string` | `"10"` | no |
| <a name="input_nodegroup_min_size"></a> [nodegroup\_min\_size](#input\_nodegroup\_min\_size) | Nodegroup min size | `string` | `"10"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of private subnets | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | IDs of public subnets | `list(string)` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | stack name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to the vpc | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of AWS VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | URL of cluster OIDC provider |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | ARN of cluster OIDC provider |
<!-- END_TF_DOCS -->