variable "name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "The Azure Region"
}

variable "rg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
