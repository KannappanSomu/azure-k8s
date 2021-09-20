output "k8s_name" {
  value = azurerm_kubernetes_cluster.practise.name
}

output "k8s_host"{                   
value = azurerm_kubernetes_cluster.practise.kube_config.0.host
}