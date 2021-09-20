variable "client_secret" {
}

variable "client_id" {
  default = "a90a2230-4303-412c-8752-8243a557503d"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "f20d9007-2df4-404d-b242-01edf5bd1992"
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = "81fa766e-a349-4867-8bf4-ab35e250a08f"
}

module "azurerm_virtual_network"  {
  source = "./modules/vnet"
  name                = "k8-network"
  location            = "West Europe"
  resource_group_name = "kubernetes-rg"
  address_space       = ["10.0.0.0/16"]
} 

module "azurerm_kubernetes_cluster"  {
  source = "./modules/k8s"
  cluster_name        = "aks-cluster"
  location            = "West Europe"
  resource_group_name = "kubernetes-rg"
  dns_prefix          = "aks-cluster"
  depends_on          = [module.azurerm_virtual_network]
  vnet_subnet_id      = module.azurerm_virtual_network.subnet_id
  client_id           = var.client_id
  client_secret       = var.client_secret
}

data "azurerm_kubernetes_cluster" "k8s" {
  name                = module.azurerm_kubernetes_cluster.k8s_name
  resource_group_name = "kubernetes-rg"
  depends_on = [
    module.azurerm_kubernetes_cluster
  ]
}

provider "kubectl" {
  load_config_file       = false
  host                   = module.azurerm_kubernetes_cluster.k8s_host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)

}

data "kubectl_path_documents" "manifests" {
    pattern = "${path.module}/manifests/*.yaml"
}

resource "kubectl_manifest" "test" {
    count     = length(data.kubectl_path_documents.manifests.documents)
    yaml_body = element(data.kubectl_path_documents.manifests.documents, count.index)
}