provider "azurerm" {
  version = "=2.13.0"

  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "aks-cluster"
  location = "uksouth"
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
