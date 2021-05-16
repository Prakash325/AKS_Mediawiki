resource "azurerm_virtual_network" "aksvnet" {
  name                = "aks-vnet"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "aks-default-subnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.k8s.name
  address_prefixes     = ["10.1.0.0/22"]
}
