## Network interface common vars
variable "network_interface_name" {
  description = "The name of the Network Interface. Changing this forces a new resource to be created"
  type        = string
  default     = "nic"
}

variable "ip_configuration" {
  description = "ip config details of network network interface."
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "The tags to associate with your network network interface."
  type        = map(string)
  default     = {}
}

