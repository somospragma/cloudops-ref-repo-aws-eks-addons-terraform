###########################################
# Locals - PC-IAC-026 Transformation Pattern
###########################################

locals {
  # Prefijo de gobernanza
  governance_prefix = "${var.client}-${var.project}-${var.environment}"
  
  # Transformación de configuración de addons con inyección de IDs dinámicos
  addons_config_transformed = {
    for key, config in var.addons_config : key => merge(config, {
      # Inyectar cluster name desde data source si está vacío
      cluster_name = length(config.cluster_name) > 0 ? config.cluster_name : data.aws_eks_cluster.selected.name
      
      # Transformar addons inyectando service account role ARNs
      addons = {
        for addon_key, addon in config.addons : addon_key => merge(addon, {
          # Inyectar service account role ARN si está vacío y el addon lo requiere
          service_account_role_arn = try(addon.service_account_role_arn, null) == null || try(addon.service_account_role_arn, "") == "" ? (
            contains(["aws-ebs-csi-driver", "aws-efs-csi-driver"], addon_key) ? data.aws_iam_role.addon_roles[addon_key].arn : null
          ) : addon.service_account_role_arn
        })
      }
    })
  }
}
