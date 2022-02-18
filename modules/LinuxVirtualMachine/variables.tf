
## linux_virtual_machine common vars

variable "linux_vm_name" {
  description = "name of the azure vm"
  type        = string
  default     = "linux"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "(Optional) The location in which the resources will be created."
  type        = string
  default     = ""
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

variable "admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure."
  type        = string
  default     = ""
  sensitive   = true
}

variable "network_interface_ids" {
  description = "A list of Network Interface ID's which should be associated with the Virtual Machine"
  type        = list(string)
  default     = []
}

variable "provision_vm_agent" {
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true"
  type        = bool
  default     = true
}

variable "source_image_id" {
  description = "The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created"
  type        = string
  default     = null
}

variable "allow_extension_operations" {
  description = "Should Extension Operations be allowed on this Virtual Machine"
  type        = bool
  default     = true
}

variable "dedicated_host_id" {
  description = "The ID of a Dedicated Host where this machine should be run on"
  type        = string
  default     = null
}

variable "computer_name" {
  description = "Specifies the Hostname which should be used for this Virtual Machine"
  type        = string
  default     = ""
}

variable "custom_data" {
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine"
  type        = string
  default     = null
}

variable "disable_password_authentication" {
  description = "Should Password Authentication be disabled on this Virtual Machine? Defaults to true"
  type        = bool
  default     = false
}

variable "encryption_at_host_enabled" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  type        = bool
  default     = false
}

variable "eviction_policy" {
  description = "Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance"
  type        = string
  default     = null
}

variable "max_bid_price" {
  description = "The maximum price you're willing to pay for this Virtual Machine, in US Dollars"
  type        = number
  default     = null
}

variable "priority" {
  description = "Specifies the duration allocated for all extensions to start"
  type        = string
  default     = "Regular"
}

variable "proximity_placement_group_id" {
  description = "proximity_placement_group_id"
  type        = string
  default     = null
}

variable "virtual_machine_scale_set_id" {
  description = "Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within"
  type        = string
  default     = null
}

variable "availability_set_id" {
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist"
  type        = string
  default     = null
}

variable "zones" {
  description = "A list of a single item of the Availability Zone which the Virtual Machine should be allocated in"
  type        = string
  default     = null
}

variable "linux_vm_tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(string)
  default     = {}
}

# secret vars
variable "secret" {
  description = "secret reference block"
  type        = map(string)
  default     = {}
}

# os disk vars
variable "os_disk" {
  description = "os disk reference block"
  type        = list(map(string))
  default     = []
}

# additional capabilities vars
variable "enable_ultra_ssd" {
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine"
  type        = bool
  default     = false
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

# boot_diagnostics vars
variable "boot_diagnostics_sa_type" {
  description = "The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics"
  type        = string
  default     = ""
}

# plan vars
variable "plan" {
  description = "image details form the market place"
  type        = list(map(string))
  default     = []
}

# identity vars
variable "identity" {
  description = "The Managed Service Identity Type of this Virtual Machine."
  type        = any
  default     = []
}