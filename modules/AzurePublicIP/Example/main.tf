
module "public_ip" {
  source              = "../modules/azurerm/AzureNetwork/public_ip"
  public_ip_name      = var.public_ip_name
  location            = module.rg.az_resource_group_location
  resource_group_name = module.rg.az_resource_group_name
  tags                = var.tags
  ip_address          = var.ip_address
}
