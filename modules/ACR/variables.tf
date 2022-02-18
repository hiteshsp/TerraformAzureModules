
## container registry common vars

variable "container_registry_name" {
  description = "Specifies the name of the Container Registry. Changing this forces a new resource to be created"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic"
  type        = string
  default     = "Basic"
}

variable "acr_tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

variable "georeplication_locations" {
  description = "A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = null
}

# network_rule_set block vars
variable "network_rule_set" {
  description = " A network_rule_set block as documented https://www.terraform.io/docs/providers/azurerm/r/container_registry.html"
  type        = any
  default     = {}
}