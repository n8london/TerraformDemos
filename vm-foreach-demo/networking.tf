resource "azurerm_virtual_network" "test" {
  name                = join("-", [var.prefix, "virtual_network"])
  resource_group_name = azurerm_resource_group.test.name
  address_space       = [var.vnet_address_space]
  location            = var.location
}

resource "azurerm_subnet" "test" {
  name                 = join("-", [var.prefix, "subnet"])
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefix       = var.subnet_address_prefix
}

resource "azurerm_public_ip" "test" {
  count               = var.resource_count
  name                = join("-", [var.prefix, "publicip", count.index])
  resource_group_name = azurerm_resource_group.test.name
  location            = var.location
  allocation_method   = "Dynamic"

}

resource "azurerm_network_interface" "test" {
  count               = var.resource_count
  name                = join("-", [var.prefix, "nic", count.index])
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "ipconfig1"
    public_ip_address_id          = azurerm_public_ip.test[count.index].id
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [azurerm_public_ip.test]
}
