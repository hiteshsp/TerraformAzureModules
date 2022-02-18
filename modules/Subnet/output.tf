## Subnet outputs

output "az_subnet_id" {
  description = "Id of the created subnet"
  value       = azurerm_subnet.az_subnet.id
}

output "az_subnet_name" {
  description = "Names of the created subnet"
  value       = azurerm_subnet.az_subnet.name
}

output "az_subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  value       = azurerm_subnet.az_subnet.address_prefixes
}

output "az_subnet_virtual_network_name" {
  description = "The name of the virtual network in which the subnet is created in"
  value       = azurerm_subnet.az_subnet.virtual_network_name
}

output "az_subnet_cidrs_map" {
  description = "The address prefixes for the subnet"
  value = {
    (azurerm_subnet.az_subnet.name) = azurerm_subnet.az_subnet.address_prefixes
  }
}
