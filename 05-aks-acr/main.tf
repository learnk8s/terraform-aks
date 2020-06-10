provider "azurerm" {
  version = "=2.13.0"

  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "aks-cluster"
  location = "uksouth"
}

data "azurerm_user_assigned_identity" "default" {
  name                = "${azurerm_kubernetes_cluster.cluster.name}-agentpool"
  resource_group_name = azurerm_kubernetes_cluster.cluster.node_resource_group
}

resource "azurerm_container_registry" "default" {
  name                = "uniquenameregistry1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  admin_enabled       = true
  sku                 = "Standard"
}

resource "azurerm_role_assignment" "aks_sp_container_registry" {
  scope                            = azurerm_container_registry.default.id
  role_definition_name             = "AcrPull"
  principal_id                     = data.azurerm_user_assigned_identity.default.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name       = "aks"
  location   = azurerm_resource_group.rg.location
  dns_prefix = "aks"

  resource_group_name = azurerm_resource_group.rg.name
  kubernetes_version  = "1.18.2"

  default_node_pool {
    name       = "aks"
    node_count = "1"
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "container_registry_username" {
  value = azurerm_container_registry.default.admin_username
}

output "container_registry_password" {
  value = azurerm_container_registry.default.admin_password
}

output "container_registry_url" {
  value = azurerm_container_registry.default.login_server
}
