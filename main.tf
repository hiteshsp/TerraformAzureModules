module "resource_group" {
  source   = "./modules/ResourceGroup"
  location = var.location
  name     = var.name
  rg_tags  = var.rg_tags
}

module "virtual_network" {
  for_each = var.vnets

  source               = "./modules/VNet"
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = module.resource_group.az_resource_group_name
  location             = var.location
  vnet_address_space   = each.value.vnet_address_space
  dns_servers          = each.value.dns_servers
  ddos_protection_plan = each.value.ddos_protection_plan
  vnet_tags            = each.value.vnet_tags
}

module "subnets" {
  for_each = var.subnets

  source                               = "./modules/Subnet"
  subnet_name                          = each.value.subnet_name
  resource_group_name                  = module.resource_group.az_resource_group_name
  virtual_network_name                 = module.virtual_network["vnet1"].az_virtual_network_name
  subnet_address_prefix                = each.value.subnet_address_prefix
  service_endpoints                    = each.value.service_endpoints
  subnet_delegation                    = each.value.subnet_delegation
  create_subnet_nsg_association        = each.value.create_subnet_nsg_association
  create_subnet_routetable_association = each.value.create_subnet_routetable_association
}

module "container_registry" {
  for_each = var.container_registries

  source                   = "./modules/ACR"
  container_registry_name  = each.value.container_registry_name
  location                 = module.resource_group.az_resource_group_location
  resource_group_name      = module.resource_group.az_resource_group_name
  sku                      = each.value.sku
  admin_enabled            = each.value.admin_enabled
  georeplication_locations = each.value.georeplication_locations
  acr_tags                 = each.value.acr_tags
}


module "kubernetes_cluster" {
  for_each = var.kubernetes

  source                  = "./modules/AKS"
  kubernetes_cluster_name = each.value.kubernetes_cluster_name
  location                = module.resource_group.az_resource_group_location
  resource_group_name     = module.resource_group.az_resource_group_name
  vnet_subnet_id          = module.subnets["k8s_subnet"].az_subnet_id
  kubernetes_version      = each.value.kubernetes_version
  k8s_default_pool        = each.value.k8s_default_pool
  k8s_tags                = each.value.k8s_tags
  aks_dns_prefix_name     = each.value.aks_dns_prefix_name

  depends_on = [module.subnets["k8s_subnet"]]
}


module "nsg" {
  for_each = var.nsgs

  source              = "./modules/AzureNSG"
  security_group_name = each.value.security_group_name
  location            = module.resource_group.az_resource_group_location
  resource_group_name = module.resource_group.az_resource_group_name
  nsg_tags            = each.value.nsg_tags
  nsg_rules           = each.value.nsg_rules
}


module "public_ip" {
  for_each = var.publicIPs

  source              = "./modules/AzurePublicIP"
  public_ip_name      = each.value.public_ip_name
  location            = module.resource_group.az_resource_group_location
  resource_group_name = module.resource_group.az_resource_group_name
  ip_address          = each.value.ip_address
  public_ip_tags      = each.value.public_ip_tags
}


module "network_interface" {
  for_each = var.network_interfaces

  source                    = "./modules/NetworkInterface"
  network_interface_name    = each.value.network_interface_name
  location                  = module.resource_group.az_resource_group_location
  resource_group_name       = module.resource_group.az_resource_group_name
  network_interface_tags    = each.value.network_interface_tags
  ip_configuration          = each.value.ip_configuration
  create_nsg_association    = each.value.create_nsg_association
  network_security_group_id = module.nsg["vm1"].az_network_security_group_id
  depends_on                = [module.subnets["vm_subnet"], module.public_ip]
}


module "linux_vm" {
  for_each = var.linux_vms

  source                 = "./modules/LinuxVirtualMachine"
  linux_vm_name          = each.value.linux_vm_name
  location               = module.resource_group.az_resource_group_location
  resource_group_name    = module.resource_group.az_resource_group_name
  admin_username         = each.value.admin_username
  admin_ssh_key          = each.value.admin_ssh_key
  network_interface_ids  = [module.network_interface["vm1"].az_network_interface_id]
  os_disk                = each.value.os_disk
  source_image_reference = each.value.source_image_reference
  linux_vm_tags          = each.value.linux_vm_tags
  virtual_machine_size   = each.value.virtual_machine_size

  depends_on = [module.subnets]
}
