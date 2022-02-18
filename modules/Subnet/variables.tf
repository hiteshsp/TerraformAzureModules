## Subnet common vars
variable "subnet_name" {
  description = "name of the azure subnet"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "(Required) Map of the resource groups to create"
  type        = string
  default     = ""
}

variable "virtual_network_name" {
  description = "name of the parent virtual network"
  type        = string
  default     = ""
}

variable "tags" {
  description = "tags of the resource"
  type        = map(string)
  default     = {}
}

variable "subnet_address_prefix" {
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

# subnet delegation vars
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


## Subnet nsg association vars

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

## Subnet route table association vars

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

## Subnet nat gateway association vars

variable "create_subnet_nat_gateway_association" {
  description = "condition to create subnet nat gateway association"
  type        = bool
  default     = false
}

variable "nat_gateway_id" {
  description = "The nat gateway Id to associate with the subnets"
  type        = string
  default     = ""
}
