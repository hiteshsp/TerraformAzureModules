## Network Security Group comman vars
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "network_security_group_name" {
  description = "Network security group name"
  type        = string
  default     = "nsg"
}

variable "tags" {
  description = "The tags to associate with your network security group."
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "Location (Azure Region) for the network security group."
  type        = string
  default     = ""
}

## Network Security Group rule comman vars
variable "nsg_rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
  type        = any
  default     = []
}

variable "source_address_prefix" {
  type    = list(string)
  default = ["*"]
}

variable "source_address_prefixes" {
  type    = list(string)
  default = null
}

variable "destination_address_prefix" {
  type    = list(string)
  default = ["*"]
}

variable "destination_address_prefixes" {
  type    = list(string)
  default = null
}