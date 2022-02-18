terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.42.0"
    }
  }  
    backend "azurerm" {
        resource_group_name  = "rg-visa-poc"
        storage_account_name = "servicediscoverybackend"
        container_name       = "terraformstate"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
  features {}
}
