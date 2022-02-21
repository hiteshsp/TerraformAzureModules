
variable "network_security_group_name" {
  description = "Network security group name"
  type        = string
  default     = "nsg"
}

variable "nsg_tags" {
  description = "The tags to associate with your network security group."
  type        = map(string)
  default     = {}
}

## Network Security Group rule comman vars
variable "nsg_rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
  type        = any
  default     = []
}

