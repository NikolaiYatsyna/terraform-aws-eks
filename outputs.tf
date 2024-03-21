output "cluster_name" {
  value = module.eks.cluster_name
}

output "oidc_provider_arn" {
  description = "ARN of cluster OIDC provider."
  value       = module.eks.oidc_provider_arn
}

output "oidc_provide_url" {
  description = "URL of cluster OIDC provider."
  value       = module.eks.oidc_provider
}

output "cluster_endpoint" {
  description = "Cluster url."
  value       = module.eks.cluster_endpoint
}

output "cluster_ca" {
  description = "Base64 encoded cluster CA."
  value       = module.eks.cluster_certificate_authority_data
}
