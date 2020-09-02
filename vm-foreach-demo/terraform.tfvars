prefix      = "count"
location    = "UK South"

vnet_address_space    = "10.0.0.0/16"
subnet_address_prefix = "10.0.0.0/24"

public_ip       = "false"

resource_count  = 1
vm_size         = "Standard_DS1_v2"
vm_os_publisher = "MicrosoftWindowsServer"
vm_os_offer     = "WindowsServer"
vm_os_sku       = "2019-Datacenter"
