## container registry outputs
output "az_acr_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.az_container_registry.id
}

output "az_acr_login_server" {
  description = "The URL that can be used to log into the container registry"
  value       = azurerm_container_registry.az_container_registry.login_server
}

output "az_acr_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled"
  value       = azurerm_container_registry.az_container_registry.admin_username
}

output "az_acr_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled"
  value       = azurerm_container_registry.az_container_registry.admin_password
}