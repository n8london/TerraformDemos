resource "azurerm_resource_group" "test" {
  name     = var.prefix
  location = var.location
}

resource "azurerm_virtual_machine" "test" {
  count                            = var.resource_count
  name                             = join("-", [var.prefix, "vm", count.index])
  location                         = azurerm_resource_group.test.location
  resource_group_name              = azurerm_resource_group.test.name
  network_interface_ids            = [azurerm_network_interface.test[count.index].id]
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.vm_os_publisher
    offer     = var.vm_os_offer
    sku       = var.vm_os_sku
    version   = "latest"
  }

  storage_os_disk {
    name              = join("-", [var.prefix, "osdisk", count.index])
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = join("-", [var.prefix, "vm", count.index])
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }

  os_profile_windows_config {
    timezone = "UTC"
  }
}