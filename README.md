![ci](https://github.com/LogisticsPet/terraform-aws-vpc/actions/workflows/ci.yml/badge.svg?branch=main)
![lint](https://github.com/LogisticsPet/terraform-aws-vpc/actions/workflows/lint.yml/badge.svg?branch=main)
![sec](https://github.com/LogisticsPet/terraform-aws-vpc/actions/workflows/tfsec.yml/badge.svg?branch=main)

## Introduction
Terraform module to provision EKS cluster in AWS

<!-- BEGIN_TF_DOCS -->


## Prerequisites

The following IAM policy needs to be attached to the role that is assumed during the creation of module resources:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:GetCallerIdentity",
                "ec2:DescribeImages",
                "ec2:DescribeTags",
                "ec2:DescribeSecurityGroups",
                "logs:DescribeLogGroups",
                "kms:CreateKey",
                "eks:CreateCluster",
                "kms:ListAliases",
                "eks:DescribeAddonVersions",
                "ec2:DescribeSecurityGroupRules",
                "eks:DeleteAddon",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeTags"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateOpenIDConnectProvider",
                "iam:GetOpenIDConnectProvider",
                "iam:DeleteOpenIDConnectProvider",
                "iam:TagOpenIDConnectProvider"
            ],
            "Resource": "arn:aws:iam::${AWS::AccountId}:oidc-provider/oidc.eks.*.amazonaws.com/id/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateSecurityGroup"
            ],
            "Resource": [
                "arn:aws:ec2:*:${AWS::AccountId}:security-group/*",
                "arn:aws:ec2:*:${AWS::AccountId}:vpc/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:ListPolicyVersions",
                "iam:DeletePolicy",
                "iam:TagPolicy"
            ],
            "Resource": "arn:aws:iam::${AWS::AccountId}:policy/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:DeleteLogGroup"
            ],
            "Resource": "arn:aws:logs:*:${AWS::AccountId}:log-group:/aws/eks/*/cluster:log-stream"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DeleteNodegroup"
            ],
            "Resource": "arn:aws:eks:*:${AWS::AccountId}:nodegroup/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:ListTagsLogGroup",
                "logs:DeleteLogGroup",
                "logs:CreateLogGroup",
                "logs:TagResource",
                "logs:PutRetentionPolicy"
            ],
            "Resource": [
                "arn:aws:logs:*:${AWS::AccountId}:log-group:/aws/eks/*/cluster",
                "arn:aws:logs:*:${AWS::AccountId}:log-group:/aws/eks/*/cluster:log-stream:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:PutRolePolicy",
                "iam:GetRole",
                "iam:ListRolePolicies",
                "iam:GetRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:AttachRolePolicy",
                "iam:PassRole",
                "iam:DetachRolePolicy",
                "iam:ListInstanceProfilesForRole",
                "iam:DeleteRolePolicy",
                "iam:DeleteRole"
            ],
            "Resource": "arn:aws:iam::${AWS::AccountId}:role/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:RevokeSecurityGroupEgress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:AuthorizeSecurityGroupEgress"
            ],
            "Resource": "arn:aws:ec2:*:${AWS::AccountId}:security-group/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:EnableKeyRotation",
                "kms:GetKeyRotationStatus",
                "kms:GetKeyPolicy",
                "kms:ListResourceTags",
                "kms:DescribeKey",
                "kms:ScheduleKeyDeletion",
                "kms:TagResource"
            ],
            "Resource": "arn:aws:kms:*:${AWS::AccountId}:key/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:CreateAlias",
                "kms:DeleteAlias"
            ],
            "Resource": [
                "arn:aws:kms:*:${AWS::AccountId}:alias/eks/*",
                "arn:aws:kms:*:${AWS::AccountId}:key/*"

            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:CreateNodegroup",
                "eks:CreateAddon",
                "eks:DeleteCluster",
                "eks:TagResource",
                "eks:CreateAccessEntry",
                "eks:DeleteAccessEntry"
            ],
            "Resource": "arn:aws:eks:*:${AWS::AccountId}:cluster/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeNodegroup",
                "iam:DeleteRole"
            ],
            "Resource": "arn:aws:eks:*:${AWS::AccountId}:nodegroup/*/*/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeAddon"
            ],
            "Resource": [
                "arn:aws:eks:*:${AWS::AccountId}:addon/*/aws-ebs-csi-driver/*",
                "arn:aws:eks:*:${AWS::AccountId}:addon/*/coredns/*",
                "arn:aws:eks:*:${AWS::AccountId}:addon/*/kube-proxy/*",
                "arn:aws:eks:*:${AWS::AccountId}:addon/*/vpc-cni/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteTags"
            ],
            "Resource": [
                "arn:aws:ec2:*:${AWS::AccountId}:subnet/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteSecurityGroup"
            ],
            "Resource": [
                "arn:aws:ec2:*:${AWS::AccountId}:security-group/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeAccessEntry",
                "eks:DeleteAccessEntry",
                "eks:AssociateAccessPolicy",
                "eks:DisassociateAccessPolicy",
                "eks:ListAssociatedAccessPolicies"
            ],
            "Resource": [
                "arn:aws:eks:*:${AWS::AccountId}:access-entry/*/role/${AWS::AccountId}/${GitHubActionsRole}/*"
            ]
        }
    ]
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.81.0 |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca"></a> [cluster\_ca](#output\_cluster\_ca) | Base64 encoded cluster CA. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Cluster url. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_oidc_provide_url"></a> [oidc\_provide\_url](#output\_oidc\_provide\_url) | URL of cluster OIDC provider. |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | ARN of cluster OIDC provider. |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ami id for node group | `string` | `""` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Amazon EKS Kubernetes version | `string` | `"1.29"` | no |
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
## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.private_subnet_tag](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.public_subnet_tag](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/ec2_tag) | resource |
| [aws_iam_policy.eks-node-policy](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/iam_policy) | resource |
| [aws_ami.eks_default](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/ami) | data source |
<!-- END_TF_DOCS -->