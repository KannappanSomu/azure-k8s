resource "azurerm_resource_group" "k8s" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "k8s" {
  name                = "k8-nsg"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
}

resource "azurerm_virtual_network" "k8s" {
  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.k8s.name
  address_space       = var.address_space
  tags = {
    environment = "Production"
  }
}
resource "azurerm_subnet" "k8s" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.k8s.name
  virtual_network_name = azurerm_virtual_network.k8s.name
  address_prefixes     = ["10.0.1.0/24"]
}