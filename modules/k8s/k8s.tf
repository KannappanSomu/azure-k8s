resource "azurerm_kubernetes_cluster" "practise" {
    name                = var.cluster_name
    location            = var.location
    resource_group_name = var.resource_group_name
    dns_prefix          = var.dns_prefix
    node_resource_group = var.node_resource_group
    

    default_node_pool {
        name            = "linuxpool"
        node_count      = 1
        vm_size         = "Standard_DS2_v2"
        vnet_subnet_id  = var.vnet_subnet_id
        enable_auto_scaling = true
        min_count = 1
        max_count = 3
    }

    network_profile {
    load_balancer_sku = "Standard"
    network_plugin = "kubenet"
    service_cidr        = "192.168.0.0/16" 
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip = "192.168.0.10"
    }

 service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

}