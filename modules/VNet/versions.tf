## terraform and providers version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.42.0"
    }
  }
  required_version = "0.14.4"
}
