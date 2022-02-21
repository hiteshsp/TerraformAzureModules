# -
# - Public IP
# -

resource "azurerm_public_ip" "az_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_address.allocation_method
  tags                = var.public_ip_tags

  sku                     = lookup(var.ip_address, "sku", null)
  ip_version              = lookup(var.ip_address, "ip_version", null)
  domain_name_label       = lookup(var.ip_address, "dns_prefix", null)
  idle_timeout_in_minutes = lookup(var.ip_address, "timeout", null)
  zones                   = lookup(var.ip_address, "zones", ["1"])
  reverse_fqdn            = lookup(var.ip_address, "reverse_fqdn", null)
  public_ip_prefix_id     = lookup(var.ip_address, "public_ip_prefix_id", null)
}
