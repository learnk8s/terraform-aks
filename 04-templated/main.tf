variable "service_principal_client_id" {
  description = "The Client ID for the Service Principal"
}

variable "service_principal_client_secret" {
  description = "The Client Secret for the Service Principal"
}

module "dev" {
  source = "./aks-module"

  name                            = "dev"
  service_principal_client_id     = "${var.service_principal_client_id}"
  service_principal_client_secret = "${var.service_principal_client_secret}"
}

module "preprod" {
  source = "./aks-module"

  name                            = "preprod"
  service_principal_client_id     = "${var.service_principal_client_id}"
  service_principal_client_secret = "${var.service_principal_client_secret}"
}

output "kubeconfig_dev" {
  value = "${module.dev.kube_config}"
}

output "kubeconfig_preprod" {
  value = "${module.preprod.kube_config}"
}
