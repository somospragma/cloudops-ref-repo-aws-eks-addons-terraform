variable "client" {
  description = "Nombre del cliente"
  type        = string
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "auto_mode_enabled" {
  description = "Indica si el cluster tiene Auto Mode habilitado"
  type        = bool
  default     = false
}

variable "addons_config" {
  description = "Configuración de addons para clusters EKS"
  type = map(object({
    cluster_name = string
    addons = map(object({
      addon_version                = optional(string)
      resolve_conflicts_on_create  = optional(string, "OVERWRITE")
      resolve_conflicts_on_update  = optional(string, "OVERWRITE")
      service_account_role_arn     = optional(string)
      preserve                     = optional(bool, false)
      configuration_values         = optional(string, null)
    }))
    timeouts = optional(object({
      create = optional(number, 30)
      update = optional(number, 30)
      delete = optional(number, 15)
    }), null)
    additional_tags = optional(map(string), {})
  }))
}
