# -
# - Azure linux virtual machine
# -
resource "azurerm_linux_virtual_machine" "az_linux_virtual_machine" {
  name                  = var.linux_vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.virtual_machine_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = var.network_interface_ids
  provision_vm_agent    = var.provision_vm_agent
  source_image_id       = var.source_image_id != null ? var.source_image_id : null
  tags                  = var.linux_vm_tags

  allow_extension_operations      = var.allow_extension_operations
  availability_set_id             = var.availability_set_id
  dedicated_host_id               = var.dedicated_host_id
  computer_name                   = var.computer_name == null ? var.linux_vm_name : null
  custom_data                     = var.custom_data
  disable_password_authentication = var.admin_password != null ? true : false
  encryption_at_host_enabled      = var.encryption_at_host_enabled
  eviction_policy                 = var.eviction_policy == "Deallocate" ? var.eviction_policy : null
  max_bid_price                   = var.eviction_policy == "Deallocate" ? var.max_bid_price : null
  priority                        = var.priority == "Spot" ? var.priority : null
  proximity_placement_group_id    = var.proximity_placement_group_id
  virtual_machine_scale_set_id    = var.virtual_machine_scale_set_id
  zone                            = var.availability_set_id == null ? var.zones : null

  lifecycle {
    ignore_changes = [admin_password]
  }

  # secret config block
  dynamic "secret" {
    for_each = var.secret
    content {
      key_vault_id = lookup(secret.value, "key_vault_id", null)
      certificate {
        url = lookup(secret.value, "url", null)
      }
    }
  }

  # os disk config block
  dynamic "os_disk" {
    for_each = var.os_disk
    content {
      name                      = lookup(os_disk.value, "name", null)
      disk_size_gb              = lookup(os_disk.value, "disk_size_gb", 30)
      storage_account_type      = lookup(os_disk.value, "storage_account_type", "Premium_LRS")
      caching                   = lookup(os_disk.value, "caching", "ReadWrite")
      disk_encryption_set_id    = lookup(os_disk.value, "disk_encryption_set_id", null)
      write_accelerator_enabled = lookup(os_disk.value, "write_accelerator_enabled", null)
    }
  }

  # additional capabilities config block
  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd
  }

  # admin ssh key config block
  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_key
    content {
      username   = var.admin_username
      public_key = lookup(admin_ssh_key.value, "offer", null)
    }
  }

  # source image reference config block
  dynamic "source_image_reference" {
    for_each = var.source_image_reference
    content {
      offer     = lookup(source_image_reference.value, "offer", null)
      publisher = lookup(source_image_reference.value, "publisher", null)
      sku       = lookup(source_image_reference.value, "sku", null)
      version   = lookup(source_image_reference.value, "version", null)
    }
  }

  # boot diagnostics config block
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_sa_type
  }

  # plan config block
  dynamic "plan" {
    for_each = var.plan
    content {
      name      = lookup(plan.value, "name", null)
      product   = lookup(plan.value, "product", null)
      publisher = lookup(plan.value, "publisher", null)
    }
  }

  # identity config block
  dynamic "identity" {
    for_each = var.identity

    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
}
