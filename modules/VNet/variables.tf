
## virtual network common vars

variable "virtual_network_name" {
  description = "Name of your Azure Virtual Network"
  type        = string
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of resorce group where your going place the services"
  type        = string
  default     = "rg-demo-westeurope-01"
}

variable "vnet_address_space" {
  description = "The address space to be used for the Azure virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "List of dns servers to use for virtual network"
  type        = list(string)
  default     = []
}

variable "vnet_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}


variable "vm_protection_enabled" {
  description = "condition to enable or disable A vm_protection_enabled "
  type        = bool
  default     = false
}

# ddos_protection_plan vars
variable "ddos_protection_plan" {
  description = "A ddos_protection_plan id "
  type        = map(string)
  default     = {}

}