# -
# - Network security group
# -
resource "azurerm_network_security_group" "az_network_security_group" {
  name                = var.security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.nsg_tags
}

# -
# - Network security group rules
# -
resource "azurerm_network_security_rule" "az_network_security_rules" {
  count                                      = length(var.nsg_rules)
  name                                       = lookup(var.nsg_rules[count.index], "name", "default_rule_name")
  priority                                   = lookup(var.nsg_rules[count.index], "priority")
  direction                                  = lookup(var.nsg_rules[count.index], "direction", "Inbound")
  access                                     = lookup(var.nsg_rules[count.index], "access", "Allow")
  protocol                                   = lookup(var.nsg_rules[count.index], "protocol", "Tcp")
  source_port_ranges                         = split(",", replace(lookup(var.nsg_rules[count.index], "source_port_range", "*"), "*", "0-65535"))
  destination_port_ranges                    = split(",", replace(lookup(var.nsg_rules[count.index], "destination_port_range", "*"), "*", "0-65535"))
  source_address_prefix                      = lookup(var.nsg_rules[count.index], "source_application_security_group_ids", null) == null && lookup(var.nsg_rules[count.index], "source_address_prefixes", null) == null ? lookup(var.nsg_rules[count.index], "source_address_prefix", "*") : null
  source_address_prefixes                    = lookup(var.nsg_rules[count.index], "source_application_security_group_ids", null) == null ? lookup(var.nsg_rules[count.index], "source_address_prefixes", null) : null
  destination_address_prefix                 = lookup(var.nsg_rules[count.index], "destination_application_security_group_ids", null) == null && lookup(var.nsg_rules[count.index], "destination_address_prefixes", null) == null ? lookup(var.nsg_rules[count.index], "destination_address_prefix", "*") : null
  destination_address_prefixes               = lookup(var.nsg_rules[count.index], "destination_application_security_group_ids", null) == null ? lookup(var.nsg_rules[count.index], "destination_address_prefixes", null) : null
  description                                = lookup(var.nsg_rules[count.index], "description", "Security rule for ${lookup(var.nsg_rules[count.index], "name", "default_rule_name")}")
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = azurerm_network_security_group.az_network_security_group.name
  source_application_security_group_ids      = lookup(var.nsg_rules[count.index], "source_application_security_group_ids", null)
  destination_application_security_group_ids = lookup(var.nsg_rules[count.index], "destination_application_security_group_ids", null)
}