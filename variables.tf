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

variable "virtual_network_name" {
  description = "Name of your Azure Virtual Network"
  type        = string
  default     = ""
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

## Subnet vars
variable "vm_subnet_name" {
  description = "name of the azure subnet"
  type        = string
  default     = ""
}

variable "plan" {
  description = "image details form the market place"
  type        = list(map(string))
  default     = []
}

variable "vm_subnet_address_prefix" {
  description = "The address prefix list to use for the subnet"
  type        = list(string)
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet"
  type        = list(string)
  default     = []
}

variable "enforce_private_link" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet"
  type        = bool
  default     = false
}

variable "enforce_private_link_service_network_policies" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet"
  type        = bool
  default     = false
}

variable "subnet_delegation" {
  description = <<EOD
Configuration delegations on subnet
object({
  name = object({
    name = string,
    actions = list(string)
  })
})
EOD
  type        = map(list(any))
  default     = {}
}

variable "create_subnet_nsg_association" {
  description = "condition to create subnet nsg association"
  type        = bool
  default     = false
}

variable "network_security_group_id" {
  description = "The Network Security Group Id to associate with the subnets"
  type        = string
  default     = ""
}

variable "create_subnet_routetable_association" {
  description = "condition to create subnet route table association"
  type        = bool
  default     = false
}

variable "route_table_id" {
  description = "The route table Id to associate with the subnets"
  type        = string
  default     = ""
}



## container registry common vars

variable "container_registry_name" {
  description = "Specifies the name of the Container Registry. Changing this forces a new resource to be created"
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


## kubernetes cluster common vars

variable "kubernetes_cluster_name" {
  description = "The name of the Managed Kubernetes Cluster to create."
  type        = string
  default     = ""
}

variable "k8s_subnet_name" {
  description = "name of the azure subnet"
  type        = string
  default     = ""
}

variable "k8s_subnet_address_prefix" {
  description = "The address prefix list to use for the subnet"
  type        = list(string)
}

variable "aks_dns_prefix_name" {
  description = "The prefix for the resources created in the specified Azure Resource Group"
  type        = string
  default     = ""
}

variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}

variable "enable_role_based_access_control" {
  description = "Enable Role Based Access Control."
  type        = bool
  default     = false
}

variable "k8s_default_pool" {
  description = "(Required in 2.0) default_pool (only one allowed in 2.6.0)"
  type        = any
}

variable "node_resource_group" {
  description = "The name of the Resource Group where the Kubernetes Nodes should exist."
  type        = string
  default     = null
}

variable "private_cluster_enabled" {
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet."
  type        = bool
  default     = false
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid"
  type        = string
  default     = "Free"
}

variable "k8s_tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}


## linux_virtual_machine common vars

variable "linux_vm_name" {
  description = "name of the azure vm"
  type        = string
  default     = "linux"
}

variable "virtual_machine_size" {
  description = "Specifies the size of the virtual machine."
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed."
  type        = string
  default     = "adminuser"
}

variable "network_interface_ids" {
  description = "A list of Network Interface ID's which should be associated with the Virtual Machine"
  type        = list(string)
  default     = []
}

variable "provision_vm_agent" {
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true"
  type        = bool
  default     = false
}

variable "linux_vm_tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(string)
  default     = {}
}

variable "os_disk" {
  description = "os disk reference block"
  type        = list(map(string))
  default     = []
}

# admin ssh key vars
variable "admin_ssh_key" {
  description = "Specifies public_key of admin user."
  type        = any
  default     = {}
}

# source_image_reference reference vars
variable "source_image_reference" {
  description = "Virtual Machine source image information. See https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html#storage_image_reference. This variable cannot be used if `vm_image_id` is already defined."
  type        = any
  default     = {}
}



## Network interface common vars
variable "network_interface_name" {
  description = "The name of the Network Interface. Changing this forces a new resource to be created"
  type        = string
  default     = "nic"
}

# ip config vars

variable "ip_configuration" {
  description = "A list of IP Addresses defining the DNS Servers which should be used for this Network Interface"
  type        = list(map(any))
}

variable "network_interface_tags" {
  description = "The tags to associate with your network network interface."
  type        = map(string)
  default     = {}
}
