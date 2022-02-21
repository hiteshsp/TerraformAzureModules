
## Public_IP common vars

variable "public_ip_name" {
  description = "Name of the public IP to be created"
  type        = string
  default     = ""
}


variable "tags" {
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

