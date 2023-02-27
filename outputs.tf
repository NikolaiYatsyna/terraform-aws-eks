output "oidc_provider_arn" {
  description = "ARN of cluster OIDC provider"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  description = "URL of cluster OIDC provider"
  value       = module.eks.oidc_provider
}
