# -
# - Azure Resource Group
# -
resource "azurerm_resource_group" "az_resource_group" {
  name     = var.name
  location = var.location
  tags     = var.rg_tags
}
