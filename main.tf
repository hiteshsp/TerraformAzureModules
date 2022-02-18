
# module "resource_group" {
#   source              = "./modules/ResourceGroup"
#   location            = var.location
#   resource_group_name = var.name
#   rg_tags             = var.rg_tags
# }


# module "virtual_network" {
#   source               = "./modules/vnet"
#   virtual_network_name = var.virtual_network_name
#   resource_group_name  = module.rg.az_resource_group_name
#   vnet_address_space   = var.vnet_address_space
#   dns_servers          = var.dns_servers
#   create_ddos_plan     = var.create_ddos_plan
#   ddos_plan_name       = var.ddos_plan_name
#   vnet_tags            = var.vnet_tags
# }

# module "subnet" {
#   source                        = "./modules/subnet"
#   subnet_name                   = var.subnet_name
#   resource_group_name           = module.rg.az_resource_group_name
#   virtual_network_name          = module.vnet.az_virtual_network_name
#   subnet_address_prefix         = var.subnet_address_prefix
#   service_endpoints             = var.service_endpoints
#   subnet_delegation             = var.subnet_delegation
#   subnet_nsg_association        = var.subnet_nsg_association
#   subnet_routetable_association = var.subnet_routetable_association
# }


# module "container_registry" {
#   source                   = "./modules/acr"
#   container_registry_name  = var.container_registry_name
#   location                 = module.rg.az_resource_group_location
#   resource_group_name      = module.rg.az_resource_group_name
#   sku                      = var.sku
#   admin_enabled            = var.admin_enabled
#   georeplication_locations = var.georeplication_locations
#   acr_tags                 = var.acr_tags
#   default_action           = var.default_action
#   network_rule_set = {
#     network_rule1 = {
#       default_action = var.default_action
#       virtual_network = [{
#         action    = "Allow"
#         subnet_id = module.subnet.az_subnet_id
#       }]
#       ip_rule = [{
#         action   = "Allow"
#         ip_range = "106.51.111.36"
#       }]
#     }
#   }
# }


# ## need to add additional nodepool block
# module "kubernetes_cluster" {
#   source                  = "/modules/aks"
#   kubernetes_cluster_name = var.kubernetes_cluster_name
#   location                = module.rg.az_resource_group_location
#   resource_group_name     = module.rg.az_resource_group_name
#   kubernetes_version      = var.kubernetes_version
#   k8s_default_pool        = var.k8s_default_pool
#   k8s_tags                = var.k8s_tags
#   aks_dns_prefix_name     = var.aks_dns_prefix_name
# }

