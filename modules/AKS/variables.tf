## kubernetes cluster common vars

variable "kubernetes_cluster_name" {
  description = "The name of the Managed Kubernetes Cluster to create."
  type        = string
  default     = ""
}

variable "location" {
  description = "Define the region where the resource groups will be created"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
  default     = ""
}

variable "aks_dns_prefix_name" {
  description = "The prefix for the resources created in the specified Azure Resource Group"
  type        = string
  default     = ""
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "The IP ranges to whitelist for incoming traffic to the masters."
  default     = []
}

variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}

variable "node_resource_group" {
  description = "The name of the Resource Group where the Kubernetes Nodes should exist."
  type        = string
  default     = null
}

variable "private_cluster_enabled" {
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet."
  type        = bool
  default     = false
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid"
  type        = string
  default     = "Free"
}

variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "k8s_tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

# addon profile  vars
variable "addon_profile" {
  description = "AddOn Profile block."
  default     = {}
}
# auto scaler profile vars
variable "auto_scaler_profile" {
  description = "auto scaling profile for aks"
  type        = any
  default     = []
}

## active directory config vars
variable "enable_role_based_access_control" {
  description = "Enable Role Based Access Control."
  type        = bool
  default     = false
}

variable "rbac_aad_managed" {
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  type        = bool
  default     = false
}

variable "rbac_aad_admin_group_object_ids" {
  description = "Object ID of groups with admin access."
  type        = list(string)
  default     = null
}

variable "rbac_aad_client_app_id" {
  description = "The Client ID of an Azure Active Directory Application."
  type        = string
  default     = null
}

variable "rbac_aad_server_app_id" {
  description = "The Server ID of an Azure Active Directory Application."
  type        = string
  default     = null
}

variable "rbac_aad_server_app_secret" {
  description = "The Server Secret of an Azure Active Directory Application."
  type        = string
  default     = null
}

# default node-pool config vars
variable "k8s_default_pool" {
  description = "(Required in 2.0) default_pool (only one allowed in 2.6.0)"
  type        = any
}

# linux_profile config vars
variable "linux_profile" {
  description = "Username and ssh key for accessing Linux machines with ssh."
  type        = object({ username = string, ssh_key = string })
  default     = null
}

# windows_profile config var
variable "windows_profile" {
  description = "Admin username and password for Windows hosts."
  type        = object({ username = string, password = string })
  default     = null
}

# network_profile config vars
variable "network_profile" {
  description = "Sets up network profile for Advanced Networking."
  type        = any
  default     = {}
}

# service_principal config vars
variable "client_id" {
  description = "The Client ID (appId) for the Service Principal used for the AKS deployment"
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
  type        = string
  default     = ""
}


variable "aci_connector_linux_subnet_name" {
  description = "The subnet name for the virtual nodes to run"
  type        = any
  default     = []
}

variable "monitoring_log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace which the OMS Agent should send data to."
  type        = string
  default     = ""
}


## kubernetes cluster node pool
variable "additional_node_pools" {
  description = "List of additional node pools"
  type        = any
  default     = {}
}

# Disk encryption with custom keys
variable "key_vault_id" {
  description = "id of the key vault"
  type        = string
  default     = ""
}

variable "key_vault_key_id" {
  description = "id of the key vault key"
  type        = string
  default     = ""
}

variable "disk_encryption_set_enabled_aks" {
  description = "condition whether to create disk encryption set"
  type        = bool
}