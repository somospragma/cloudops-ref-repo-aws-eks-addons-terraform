###########################################
# Outputs
###########################################

output "addon_arns" {
  description = "ARNs de los addons instalados"
  value       = module.eks_addons.addon_arns
}

output "addon_ids" {
  description = "IDs de los addons instalados"
  value       = module.eks_addons.addon_ids
}
