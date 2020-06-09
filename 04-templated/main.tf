module "dev_cluster" {
  source = "./aks-module"
  name   = "dev"
}

module "preprod_cluster" {
  source = "./aks-module"

  name = "preprod"
}

output "kubeconfig_dev" {
  value = module.dev_cluster.kube_config
}

output "kubeconfig_preprod" {
  value = module.preprod_cluster.kube_config
}

