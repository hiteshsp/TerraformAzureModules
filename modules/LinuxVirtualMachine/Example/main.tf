
module "az_linux_vm" {
  source                = "../modules/azurerm/AzureCompute/linux_virtual_machine"
  linux_vm_name         = var.linux_vm_name
  location              = module.rg.az_resource_group_location
  resource_group_name   = module.rg.az_resource_group_name
  admin_username        = var.admin_username
  admin_password        = module.vm_secret.az_key_vault_secrets_value
  network_interface_ids = [module.nic.az_network_interface_id]
  os_disk               = var.os_disk
  vm_image              = var.vm_image
  linux_vm_tags         = var.linux_vm_tags
  virtual_machine_size  = var.virtual_machine_size
}

