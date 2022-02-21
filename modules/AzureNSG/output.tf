## Network security group outputs

output "az_network_security_group_id" {
  description = "The ID of the Network Security Group"
  value       = azurerm_network_security_group.az_network_security_group.id
}

output "az_network_security_group_name" {
  description = "The name of the Network Security Group"
  value       = azurerm_network_security_group.az_network_security_group.name
}