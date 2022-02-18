
# resource group outputs
output "az_resource_group_id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.az_resource_group.id
}

output "az_resource_group_name" {
  description = "The Azure Region where the Resource Group exists"
  value       = azurerm_resource_group.az_resource_group.name
}

output "az_resource_group_location" {
  description = "A mapping of tags assigned to the Resource Group"
  value       = azurerm_resource_group.az_resource_group.location
}
