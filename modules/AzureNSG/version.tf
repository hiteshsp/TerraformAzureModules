## terraform and providers version
terraform {
  required_version = "~> 0.14.2"
  required_providers {
    azurerm = {
      version = "~> 2.41.0"
      source  = "hashicorp/azurerm"
    }
  }
}