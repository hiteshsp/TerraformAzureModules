module "resource_group" {
   source              = "./modules/ResourceGroup"
   location            = var.location
   name                = var.name
   rg_tags             = var.rg_tags
}

module "virtual_network" {
   source                     = "./modules/VNet"
   virtual_network_name       = var.virtual_network_name
   resource_group_name        = module.resource_group.az_resource_group_name
   location                   = var.location
   vnet_address_space         = var.vnet_address_space
   dns_servers                = var.dns_servers
   ddos_protection_plan       = var.ddos_protection_plan
   vnet_tags                  = var.vnet_tags
}

module "vm_subnet" {   
   source                        = "./modules/Subnet"
   subnet_name                   = var.vm_subnet_name
   resource_group_name           = module.resource_group.az_resource_group_name
   virtual_network_name          = module.virtual_network.az_virtual_network_name
   subnet_address_prefix         = var.vm_subnet_address_prefix
   service_endpoints             = var.service_endpoints
   subnet_delegation             = var.subnet_delegation
   create_subnet_nsg_association        = var.create_subnet_nsg_association
   create_subnet_routetable_association = var.create_subnet_routetable_association
 }

 module "container_registry" {
   source                   = "./modules/ACR"
   container_registry_name  = var.container_registry_name
   location                 = module.resource_group.az_resource_group_location
   resource_group_name      = module.resource_group.az_resource_group_name
   sku                      = var.sku
   admin_enabled            = var.admin_enabled
   georeplication_locations = var.georeplication_locations
   acr_tags                 = var.acr_tags
 }


 module "k8s_subnet" {   
   source                        = "./modules/Subnet"
   subnet_name                   = var.k8s_subnet_name
   resource_group_name           = module.resource_group.az_resource_group_name
   virtual_network_name          = module.virtual_network.az_virtual_network_name
   subnet_address_prefix         = var.k8s_subnet_address_prefix
   service_endpoints             = var.service_endpoints
   subnet_delegation             = var.subnet_delegation
   create_subnet_nsg_association        = var.create_subnet_nsg_association
   create_subnet_routetable_association = var.create_subnet_routetable_association
 }


 module "kubernetes_cluster" {
   source                  = "./modules/AKS"
   kubernetes_cluster_name = var.kubernetes_cluster_name
   location                = module.resource_group.az_resource_group_location
   resource_group_name     = module.resource_group.az_resource_group_name
   vnet_subnet_id          = module.k8s_subnet.az_subnet_id
   kubernetes_version      = var.kubernetes_version
   k8s_default_pool        = var.k8s_default_pool
   k8s_tags                = var.k8s_tags
   aks_dns_prefix_name     = var.aks_dns_prefix_name

   depends_on = [ module.k8s_subnet ]
 }


module "network_interface" {
  source                 = "./modules/NetworkInterface"
  network_interface_name = var.network_interface_name
  location               = module.resource_group.az_resource_group_location
  resource_group_name    = module.resource_group.az_resource_group_name
  network_interface_tags = var.network_interface_tags
  ip_configuration       = var.ip_configuration

  depends_on = [module.vm_subnet]
}

 
module "linux_vm" {
  source                = "./modules/LinuxVirtualMachine"
  linux_vm_name         = var.linux_vm_name
  location              = module.resource_group.az_resource_group_location
  resource_group_name   = module.resource_group.az_resource_group_name
  admin_username        = var.admin_username
  admin_ssh_key         = var.admin_ssh_key
  network_interface_ids = [module.network_interface.az_network_interface_id]
  os_disk               = var.os_disk
  source_image_reference = var.source_image_reference
  linux_vm_tags         = var.linux_vm_tags
  virtual_machine_size  = var.virtual_machine_size

  depends_on = [module.vm_subnet]
}
