###########################################
# EKS Addons Module - Sample
# PC-IAC-026: Consumir SOLO local.* (nunca var.* directo)
###########################################

module "eks_addons" {
  source = "../"
  
  providers = {
    aws.project = aws.principal
  }
  
  # Variables de gobernanza
  client      = var.client
  project     = var.project
  environment = var.environment
  
  # Indicar si el cluster tiene Auto Mode
  auto_mode_enabled = var.auto_mode_enabled
  
  # ✅ Consumir configuración transformada desde locals (PC-IAC-026)
  addons_config = local.addons_config_transformed
}
