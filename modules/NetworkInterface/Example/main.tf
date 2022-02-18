
module "network_interface" {
  source                 = "../modules/azurerm/AzureNetwork/network_interface"
  network_interface_name = var.network_interface_name
  location               = module.rg.az_resource_group_location
  resource_group_name    = module.rg.az_resource_group_name
  network_interface_tags = var.tags
  ip_configuration_name  = var.ip_configuration_name
}



