
## Virtual network outputs

output "az_virtual_network_id" {
  description = "The id of the virtual network"
  value       = azurerm_virtual_network.az_virtual_network.id
}

output "az_virtual_network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.az_virtual_network.name
}

output "az_virtual_network_address_space" {
  description = "List of address spaces that are used the virtual network."
  value       = azurerm_virtual_network.az_virtual_network.address_space
}

