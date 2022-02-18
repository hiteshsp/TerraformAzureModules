# -
# - Azure container registry
# -
resource "azurerm_container_registry" "az_container_registry" {
  name                     = var.container_registry_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  georeplication_locations = var.georeplication_locations
  tags                     = var.acr_tags


  # network rule set config block
  dynamic "network_rule_set" {
    for_each = var.network_rule_set

    content {
      default_action = lookup(network_rule_set.value, "default_action", "Deny")

      dynamic "ip_rule" {
        for_each = lookup(network_rule_set.value, "ip_rule", {})

        content {
          action   = lookup(ip_rule.value, "action", null)
          ip_range = lookup(ip_rule.value, "ip_range", null)
        }
      }
      dynamic "virtual_network" {
        for_each = lookup(network_rule_set.value, "virtual_network", {})

        content {
          action    = lookup(virtual_network.value, "action", null)
          subnet_id = lookup(virtual_network.value, "subnet_id", null)
        }
      }
    }
  }
  lifecycle {
    ignore_changes = [
      georeplication_locations
    ]
  }
}
