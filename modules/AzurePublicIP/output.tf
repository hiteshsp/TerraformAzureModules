## public_IP outputs

output "az_publicip_id" {
  description = "Output the full object"
  value       = azurerm_public_ip.az_public_ip.id
}

output "az_ip_address" {
  description = "Output the ip address"
  value       = azurerm_public_ip.az_public_ip.ip_address
}

output "az_fqdn" {
  description = "Output the fully qualified domain name"
  value       = azurerm_public_ip.az_public_ip.fqdn
}