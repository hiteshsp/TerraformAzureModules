
## Public_IP common vars

variable "public_ip_name" {
  description = "Name of the public IP to be created"
  type        = string
  default     = ""
}

variable "location" {
  description = "Location of the public IP to be created"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Resource group of the public IP to be created"
  type        = string
  default     = ""
}

variable "public_ip_tags" {
  description = "Tags to be applied to the IP address to be created"
  type        = map(string)
  default     = {}

}

# IP address vars
variable "ip_address" {
  description = "Object with the settings for public IP deployment"
  type        = any
  default     = {}
}

