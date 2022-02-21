
module "nsg" {
  source                      = "../modules/azurerm/AzureNetwork/network_security_group"
  network_security_group_name = var.network_security_group_name
  location                    = module.rg.az_resource_group_location
  resource_group_name         = module.rg.az_resource_group_name
  nsg_tags                    = var.nsg_tags
  nsg_rules                   = var.nsg_rules
}




