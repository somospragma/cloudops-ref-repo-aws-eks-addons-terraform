locals {
  # Addons gestionados automáticamente por EKS Auto Mode (no deben instalarse manualmente)
  # Fuente: https://docs.aws.amazon.com/eks/latest/best-practices/automode.html
  auto_mode_incompatible_addons = toset([
    "karpenter",                    # Auto-scaling gestionado por Auto Mode
    "aws-load-balancer-controller", # Load balancing gestionado por Auto Mode
    "aws-ebs-csi-driver"           # Storage gestionado por Auto Mode (aunque el addon debe existir)
  ])
  
  # Aplanar la configuración de addons para facilitar su uso con for_each
  flattened_addons = flatten([
    for cluster_key, cluster in var.addons_config : [
      for addon_key, addon in cluster.addons : {
        cluster_key     = cluster_key
        addon_key       = addon_key
        addon           = addon
        cluster_name    = cluster.cluster_name
        additional_tags = cluster.additional_tags
        timeouts        = cluster.timeouts
      }
    ]
  ])
  
  # Validar addons incompatibles con Auto Mode
  invalid_addons_for_auto_mode = var.auto_mode_enabled ? [
    for addon in local.flattened_addons : addon.addon_key
    if contains(local.auto_mode_incompatible_addons, addon.addon_key)
  ] : []
  
  # Crear un mapa con claves únicas para usar con for_each
  addons_map = {
    for addon in local.flattened_addons : "${addon.cluster_key}-${addon.addon_key}" => addon
  }
}
