# -
# - Azure kubernetes cluster
# -
resource "azurerm_kubernetes_cluster" "az_kubernetes_cluster" {
  name                            = var.kubernetes_cluster_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  dns_prefix                      = var.aks_dns_prefix_name
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges
  kubernetes_version              = var.kubernetes_version
  node_resource_group             = var.node_resource_group
  private_cluster_enabled         = var.private_cluster_enabled
  sku_tier                        = var.sku_tier
  disk_encryption_set_id          = var.disk_encryption_set_enabled_aks == true ? azurerm_disk_encryption_set.az_disk_encryption_set[0].id : null

  # addon profile config block
  addon_profile {
    dynamic "oms_agent" {
      for_each = lookup(var.addon_profile, "oms_agent_enabled", false) == true ? [1] : []
      content {
        enabled                    = var.addon_profile.oms_agent_enabled
        log_analytics_workspace_id = var.monitoring_log_analytics_workspace_id
      }
    }
    dynamic "aci_connector_linux" {
      for_each = lookup(var.addon_profile, "aci_connector_linux_enabled", false) == true ? [1] : []
      content {
        enabled     = var.addon_profile.aci_connector_linux
        subnet_name = var.aci_connector_linux_subnet_name
      }
    }
    dynamic "http_application_routing" {
      for_each = lookup(var.addon_profile, "http_application_routing_enabled", false) == true ? [1] : []
      content {
        enabled = var.addon_profile.http_application_routing_enabled
      }
    }
    kube_dashboard {
      enabled = false
    }
    dynamic "azure_policy" {
      for_each = lookup(var.addon_profile, "azure_policy", false) == true ? [1] : []
      content {
        enabled = var.addon_profile.azure_policy
      }
    }
  }

  # auto scaler profile config block
  dynamic "auto_scaler_profile" {
    for_each = var.auto_scaler_profile
    content {
      balance_similar_node_groups      = lookup(auto_scaler_profile.value, "balance_similar_node_groups", null)
      max_graceful_termination_sec     = lookup(auto_scaler_profile.value, "max_graceful_termination_sec", null)
      scale_down_delay_after_add       = lookup(auto_scaler_profile.value, "scale_down_delay_after_add", null)
      scale_down_delay_after_delete    = lookup(auto_scaler_profile.value, "scale_down_delay_after_delete", null)
      scale_down_delay_after_failure   = lookup(auto_scaler_profile.value, "scale_down_delay_after_failure", null)
      scan_interval                    = lookup(auto_scaler_profile.value, "scan_interval", null)
      scale_down_unneeded              = lookup(auto_scaler_profile.value, "scale_down_unneeded", null)
      scale_down_unready               = lookup(auto_scaler_profile.value, "scale_down_unready", null)
      scale_down_utilization_threshold = lookup(auto_scaler_profile.value, "scale_down_utilization_threshold", null)
    }
  }

  # active directory config block
  role_based_access_control {
    enabled = var.enable_role_based_access_control

    dynamic "azure_active_directory" {
      for_each = var.enable_role_based_access_control && var.rbac_aad_managed ? ["rbac"] : []
      content {
        managed                = true
        admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      }
    }

    dynamic "azure_active_directory" {
      for_each = var.enable_role_based_access_control && !var.rbac_aad_managed ? ["rbac"] : []
      content {
        managed           = false
        client_app_id     = var.rbac_aad_client_app_id
        server_app_id     = var.rbac_aad_server_app_id
        server_app_secret = var.rbac_aad_server_app_secret
      }
    }
  }

  # default node-pool config block
  default_node_pool {
    name       = var.k8s_default_pool.name
    node_count = var.k8s_default_pool.count
    vm_size    = var.k8s_default_pool.vm_size
    /* os_disk_size_gb     = var.k8s_default_pool.os_disk_size_gb
    type                = var.k8s_default_pool.type
    availability_zones  = var.k8s_default_pool.availability_zones
    enable_auto_scaling = var.k8s_default_pool.enable_auto_scaling
    min_count           = var.k8s_default_pool.min_count
    max_count           = var.k8s_default_pool.max_count */
    max_pods       = var.k8s_default_pool.max_pods
    vnet_subnet_id = var.vnet_subnet_id
  }

  # linux_profile config block
  dynamic "linux_profile" {
    for_each = var.linux_profile != null ? [true] : []
    iterator = lp
    content {
      admin_username = var.linux_profile.username

      ssh_key {
        key_data = var.linux_profile.ssh_key
      }
    }
  }

  # windows_profile config block
  dynamic "windows_profile" {
    for_each = var.windows_profile != null ? [true] : []
    iterator = wp
    content {
      admin_username = var.windows_profile.username
      admin_password = var.windows_profile.password
    }
  }

  # network_profile config block
  dynamic "network_profile" {
    for_each = var.network_profile
    content {
      network_plugin     = lookup(network_profile.value, "network_plugin", null)
      network_policy     = lookup(network_profile.value, "network_policy", null)
      dns_service_ip     = lookup(network_profile.value, "dns_service_ip", null)
      docker_bridge_cidr = lookup(network_profile.value, "docker_bridge_cidr", null)
      outbound_type      = lookup(network_profile.value, "outbound_type", null)
      pod_cidr           = lookup(network_profile.value, "pod_cidr", null)
      service_cidr       = lookup(network_profile.value, "service_cidr", null)
    }
  }

  # service_principal config block
  dynamic "service_principal" {
    for_each = var.client_id != "" && var.client_secret != "" ? ["service_principal"] : []
    content {
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }

  dynamic "identity" {
    for_each = var.client_id == "" || var.client_secret == "" ? ["identity"] : []
    content {
      type = "SystemAssigned"
    }
  }

  tags = var.k8s_tags

  lifecycle {
    ignore_changes = [
      linux_profile["ssh_key"],
      default_node_pool["node_count"]
    ]
  }
  depends_on = [azurerm_disk_encryption_set.az_disk_encryption_set]
}


# -
# - Azure kubernetes cluster node pool
# -
resource "azurerm_kubernetes_cluster_node_pool" "az_k8s_additional_node_pool" {
  for_each              = var.additional_node_pools
  kubernetes_cluster_id = azurerm_kubernetes_cluster.az_kubernetes_cluster.id
  name                  = each.key
  vm_size               = lookup(each.value, "vm_size", null)
  availability_zones    = lookup(each.value, "availability_zones", null)
  enable_node_public_ip = lookup(each.value, "enable_node_public_ip", false)
  eviction_policy       = lookup(each.value, "eviction_policy", null)
  max_pods              = lookup(each.value, "max_pods", null)
  mode                  = lookup(each.value, "mode", null)
  node_labels           = lookup(each.value, "node_labels", null)
  node_taints           = lookup(each.value, "node_labels", null)
  orchestrator_version  = lookup(each.value, "orchestrator_version", null)
  os_disk_size_gb       = lookup(each.value, "os_disk_size_gb", null)
  os_type               = lookup(each.value, "os_type", "Linux")
  priority              = lookup(each.value, "priority", null)
  spot_max_price        = lookup(each.value, "spot_max_price", null)
  node_count            = lookup(each.value, "node_count", null)
  vnet_subnet_id        = var.vnet_subnet_id
  enable_auto_scaling   = lookup(each.value, "enable_auto_scaling", false)
  min_count             = lookup(each.value, "min_count", null)
  max_count             = lookup(each.value, "max_count", null)
  tags                  = lookup(each.value, "k8s_additional_np_tags", null)

  depends_on = [azurerm_disk_encryption_set.az_disk_encryption_set]
}


# AKS Disk Encryption Set for CMK

# -
# - Create Disk Encryption Set for AKS
# -
resource "azurerm_disk_encryption_set" "az_disk_encryption_set" {
  count               = var.disk_encryption_set_enabled_aks ? 1 : 0
  name                = "${var.kubernetes_cluster_name}-disk-cmk"
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = var.key_vault_key_id

  identity {
    type = "SystemAssigned"
  }

  tags = var.k8s_tags
}

# -
# - Adding Access Policies for Disk Encryption Set MSI
# -
resource "azurerm_key_vault_access_policy" "az_key_vault_access_cmk_policy" {
  count        = var.disk_encryption_set_enabled_aks ? 1 : 0
  key_vault_id = var.key_vault_id

  tenant_id = azurerm_disk_encryption_set.az_disk_encryption_set[0].identity[0].tenant_id
  object_id = azurerm_disk_encryption_set.az_disk_encryption_set[0].identity[0].principal_id

  key_permissions    = ["get", "decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  secret_permissions = ["get"]
}




# -
# - log analytics for aks cluster
# -
# resource "azurerm_monitor_diagnostic_setting" "log_analytics" {
#   name                       = "loganalytics-diagnostics"
#   target_resource_id         = azurerm_kubernetes_cluster.az_kubernetes_cluster.id
#   log_analytics_workspace_id = var.monitoring_log_analytics_workspace_id

#   log {
#     category = "kube-audit"
#     enabled  = true
#     retention_policy {
#       enabled = true
#     }
#   }
#   log {
#     category = "kube-apiserver"
#     enabled  = true
#     retention_policy {
#       enabled = true
#     }
#   }
#   log {
#     category = "kube-controller-manager"
#     enabled  = true
#     retention_policy {
#       enabled = true
#     }
#   }
#   log {
#     category = "kube-scheduler"
#     enabled  = true
#     retention_policy {
#       enabled = true
#     }
#   }
#   log {
#     category = "cluster-autoscaler"
#     enabled  = true
#     retention_policy {
#       enabled = true
#     }
#   }

#   metric {
#     category = "AllMetrics"

#     retention_policy {
#       enabled = true
#     }
#   }

#   lifecycle {
#     ignore_changes = [metric, log, target_resource_id]
#   }
# }
