## Network interface common vars
variable "network_interface_name" {
  description = "The name of the Network Interface. Changing this forces a new resource to be created"
  type        = string
  default     = "nic"
}

variable "location" {
  description = "The location where the Network Interface should exist. Changing this forces a new resource to be created"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Network Interface"
  type        = string
  default     = ""
}

variable "internal_dns_name_label" {
  description = "The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network"
  type        = string
  default     = null
}

variable "enable_ip_forwarding" {
  description = "Should IP Forwarding be enabled? Defaults to false"
  type        = bool
  default     = false
}

variable "enable_accelerated_networking" {
  description = "Should Accelerated Networking be enabled? Defaults to false"
  type        = bool
  default     = false
}

variable "dns_servers" {
  description = "A list of IP Addresses defining the DNS Servers which should be used for this Network Interface"
  type        = list(string)
  default     = null
}



# ip config vars


variable "ip_configuration" {
  description = "A list of IP Addresses defining the DNS Servers which should be used for this Network Interface"
  type        = list(map(any))
  default     = []
}

variable "ip_configuration_name" {
  description = "ip config details of network network interface."
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "ip config details of network network interface."
  type        = string
  default     = ""
}

variable "private_ip_allocation" {
  description = "ip config details of network network interface."
  type        = string
  default     = ""
}

variable "private_ip_address" {
  description = "ip config details of network network interface."
  type        = string
  default     = ""
}

variable "public_ip_address_id" {
  description = "ip config details of network network interface."
  type        = any
  default     = null
}

variable "public_ip_id" {
  description = "ip config details of network network interface."
  type        = string
  default     = ""
}

variable "primary" {
  description = "ip config details of network network interface."
  type        = bool
  default     = null
}

variable "network_interface_tags" {
  description = "The tags to associate with your network network interface."
  type        = map(string)
  default     = {}
}


## security_group_association vars

variable "create_nsg_association" {
  description = "condition to associate the nic to network security group"
  type        = bool
  default     = false
}

variable "network_security_group_id" {
  description = "The ID of the Network Security Group which should be attached to the Network Interface"
  type        = string
  default     = ""
}

## backend_address_pool_association vars

variable "create_backed_pool_association" {
  description = "condition to associate the nic to backend address pool"
  type        = bool
  default     = false
}

variable "backend_ip_configuration_name" {
  description = "The Name of the IP Configuration within the Network Interface which should be connected to the Backend Address Pool"
  type        = string
  default     = ""
}

variable "backend_address_pool_id" {
  description = "The ID of the Load Balancer Backend Address Pool which this Network Interface which should be connected to"
  type        = string
  default     = ""
}

## application_gateway_backend_address_pool_association vars

variable "create_appgw_backed_pool_association" {
  description = "condition to associate the nic to appgw group"
  type        = bool
  default     = false
}

variable "appgw_ip_configuration_name" {
  description = "The Name of the IP Configuration within the Network Interface which should be connected to the Backend Address Pool"
  type        = string
  default     = ""
}

variable "appgw_backend_address_pool_id" {
  description = "The ID of the Application Gateway's Backend Address Pool which this Network Interface which should be connected to"
  type        = string
  default     = ""
}

## application_security_group_association vars

variable "create_appgw_sg_association" {
  description = "condition to associate the nic to application security group"
  type        = bool
  default     = false
}

variable "application_security_group_id" {
  description = "The ID of the Application Security Group which this Network Interface which should be connected to"
  type        = string
  default     = ""
}


## interface nat_rule_association vars
variable "create_nat_rule_association" {
  description = "condition to associate the nic to nat"
  type        = bool
  default     = false
}

variable "nat_ip_configuration_name" {
  description = "The Name of the IP Configuration within the Network Interface which should be connected to the NAT Rule"
  type        = string
  default     = ""
}

variable "nat_rule_id" {
  description = "The ID of the Load Balancer NAT Rule which this Network Interface which should be connected to"
  type        = string
  default     = ""
}