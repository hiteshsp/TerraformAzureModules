module "ResourceGroup" {
  source              = "../modules/azurerm/ResourceGroup"
  location            = var.location
  resource_group_name = var.name
  rg_tags             = var.rg_tags
}
