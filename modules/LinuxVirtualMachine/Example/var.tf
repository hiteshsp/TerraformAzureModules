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
  default     = "azureuser"
}

variable "linux_vm_tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(string)
  default     = {}
}









