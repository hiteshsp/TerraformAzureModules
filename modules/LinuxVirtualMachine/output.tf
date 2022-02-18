## linux_virtual_machine outputs

output "az_linux_vm_id" {
  description = "ID of the Virtual Machine"
  value       = azurerm_linux_virtual_machine.az_linux_virtual_machine.id
}

output "az_linux_vm_private_ip_address" {
  description = "The Primary Private IP Address assigned to this Virtual Machine"
  value       = azurerm_linux_virtual_machine.az_linux_virtual_machine.private_ip_address
}

output "az_linux_vm_public_address" {
  description = "The Primary Public IP Address assigned to this Virtual Machine"
  value       = azurerm_linux_virtual_machine.az_linux_virtual_machine.public_ip_address
}

output "az_linux_vm_public_ip_addresses" {
  description = "A list of the Public IP Addresses assigned to this Virtual Machine"
  value       = azurerm_linux_virtual_machine.az_linux_virtual_machine.public_ip_addresses
}

output "az_linux_virtual_machine_id" {
  description = "The resource id's of all Linux Virtual Machine."
  value       = azurerm_linux_virtual_machine.az_linux_virtual_machine.virtual_machine_id
}