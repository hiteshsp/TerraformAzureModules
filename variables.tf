# resource group common vars
variable "name" {
  type        = string
  description = "Resource group name"
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure Region"
  default     = ""
}

variable "rg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

## virtual network common vars
variable "vnets" {
  description = "VNet block"
  type = map(object({
    virtual_network_name = string
    vnet_address_space   = list(string)
    dns_servers          = list(string)
    ddos_protection_plan = map(string)
    vnet_tags            = map(string)
  }))
}

variable "subnets" {
  description = "Subnet Block"
  type = map(object({
    subnet_name                          = string
    subnet_address_prefix                = list(string)
    service_endpoints                    = list(string)
    subnet_delegation                    = map(list(any))
    create_subnet_nsg_association        = bool
    create_subnet_routetable_association = bool
  }))
}

## container registry common vars

variable "container_registries" {
  description = "Azure ACR"
  type = map(object({
    container_registry_name  = string
    sku                      = string
    admin_enabled            = bool
    georeplication_locations = list(string)
    acr_tags                 = map(string)
  }))
  default = {}
}


## kubernetes cluster common vars

variable "kubernetes" {
  description = "Azure AKS"
  type = map(object({
    kubernetes_cluster_name = string
    kubernetes_version      = string
    k8s_default_pool        = any
    k8s_tags                = map(string)
    aks_dns_prefix_name     = string
  }))
  default = {}
}

## linux_virtual_machine common vars

variable "linux_vms" {
  description = "Azure Linux Virtual Machines"
  type = map(object({
    linux_vm_name          = string
    admin_username         = string
    admin_ssh_key          = any
    os_disk                = list(map(string))
    source_image_reference = any
    linux_vm_tags          = map(string)
    virtual_machine_size   = string
  }))
  default = {}
}

## Network interface common vars

variable "network_interfaces" {
  description = "Azure NIC"
  type = map(object({
    network_interface_name    = string
    network_interface_tags    = map(string)
    ip_configuration          = list(map(any))
    enable_ip_forwarding      = bool
    create_nsg_association    = bool
    network_security_group_id = string
  }))
  default = {}
}


## NGS Vars

variable "nsgs" {
  description = "Azure NSGs"
  type = map(object({
    network_security_group_name = string
    nsg_tags                    = map(string)
    nsg_rules                   = list(map(string))
  }))
  default = {}
}

variable "publicIPs" {
  description = "Azure Public IPs"
  type = map(object({
    public_ip_name = string
    ip_address = map(object({
      allocation_method = string
      sku               = string
      ip_version        = string
      timeout           = number
      zones             = list(number)
    }))
    tags = map(string)
  }))
  default = {}
}