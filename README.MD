## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.51.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.8.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.51.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.8.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.17.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 8.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | n/a |
| <a name="module_lb_role"></a> [lb\_role](#module\_lb\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ebs_csi_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [helm_release.aws_lb_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.nginx_ingress_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.ingress-binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_service_account.service-account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [aws_ami.eks_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_lb_target_group.ingress-tg-https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_target_group) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [kubernetes_service.nginx_ingress_service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ami id for node group | `string` | `""` | no |
| <a name="input_cert_arn"></a> [cert\_arn](#input\_cert\_arn) | SSL cert arn | `any` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Amazon EKS Kubernetes version | `string` | `"1.24"` | no |
| <a name="input_control_plane_subnets"></a> [control\_plane\_subnets](#input\_control\_plane\_subnets) | Subnets ids for control plance | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t3.micro"` | no |
| <a name="input_lb_subnets"></a> [lb\_subnets](#input\_lb\_subnets) | Public subnets for LB | `list(string)` | n/a | yes |
| <a name="input_node_subnets"></a> [node\_subnets](#input\_node\_subnets) | Subnets ids for nodes | `list(string)` | n/a | yes |
| <a name="input_nodegroup_desired_size"></a> [nodegroup\_desired\_size](#input\_nodegroup\_desired\_size) | Nodegroup desired size | `string` | `"10"` | no |
| <a name="input_nodegroup_max_size"></a> [nodegroup\_max\_size](#input\_nodegroup\_max\_size) | Nodegroup max size | `string` | `"10"` | no |
| <a name="input_nodegroup_min_size"></a> [nodegroup\_min\_size](#input\_nodegroup\_min\_size) | Nodegroup min size | `string` | `"10"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | stack name | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id to use | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name |
