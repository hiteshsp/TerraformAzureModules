# -
# - Network interface
# -
resource "azurerm_network_interface" "az_network_interface" {
  name                          = var.network_interface_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  internal_dns_name_label       = var.internal_dns_name_label
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking
  dns_servers                   = var.dns_servers


  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name                          = lookup(ip_configuration.value, "name", var.network_interface_name)
      subnet_id                     = lookup(ip_configuration.value, "subnet_id")
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation", "dynamic")
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      public_ip_address_id          = lookup(ip_configuration.value, "public_ip_address_id", null)
      primary                       = lookup(ip_configuration.value, "primary", null)
    }
  }

  tags = var.network_interface_tags
}


# -
# - Network interface security_group_association
# -
resource "azurerm_network_interface_security_group_association" "az_nsg_association" {
  count                     = var.create_nsg_association ? 1 : 0
  network_interface_id      = azurerm_network_interface.az_network_interface.id
  network_security_group_id = var.network_security_group_id
}

# -
# - Network interface lb backend_address_pool_association
# -
resource "azurerm_network_interface_backend_address_pool_association" "az_lb_backend_pool_association" {
  count                   = var.create_backed_pool_association ? 1 : 0
  network_interface_id    = azurerm_network_interface.az_network_interface.id
  ip_configuration_name   = var.backend_ip_configuration_name
  backend_address_pool_id = var.backend_address_pool_id
}

# -
# - Network interface application_gateway_backend_address_pool_association
# -
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "az_appgw_backed_pool_association" {
  count                   = var.create_appgw_backed_pool_association ? 1 : 0
  network_interface_id    = azurerm_network_interface.az_network_interface.id
  ip_configuration_name   = var.appgw_ip_configuration_name
  backend_address_pool_id = var.appgw_backend_address_pool_id
}

# -
# - Network interface application_security_group_association
# -
resource "azurerm_network_interface_application_security_group_association" "az_appgw_sg_association" {
  count                         = var.create_appgw_sg_association ? 1 : 0
  network_interface_id          = azurerm_network_interface.az_network_interface.id
  application_security_group_id = var.application_security_group_id
}

# -
# - Network interface nat_rule_association
# -
resource "azurerm_network_interface_nat_rule_association" "az_nat_rule_association" {
  count                 = var.create_nat_rule_association ? 1 : 0
  network_interface_id  = azurerm_network_interface.az_network_interface.id
  ip_configuration_name = var.ip_configuration_name
  nat_rule_id           = var.nat_rule_id
}