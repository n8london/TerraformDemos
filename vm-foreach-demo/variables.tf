# Variables filled from tfvars file
variable "prefix" {
  description = "Enter the name of the app (lower case characters only)"
  # EXAMPLE "dev"
}

variable "location" {
  description = "Location for the resources"
  # EXAMPLE "UK South"
}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  # EXAMPLE "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "Address prefix of the subnet"
  # EXAMPLE "10.0.1.0/24"
}

variable "resource_count" {
  description = "Count for the number of resources to build"
  default     = 1
}

variable "vm_size" {
  description = "Enter the size of the VM."
  # EXAMPLE "Standard_B2ms"
}

variable "vm_os_publisher" {
  description = "The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  # Example "MicrosoftWindowsServer"
}

variable "vm_os_offer" {
  description = "The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  # EXAMPLE "WindowsServer"
}

variable "vm_os_sku" {
  description = "The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  # EXAMPLE "2019-Datacenter"
}

variable "vm_admin_username" {
  description = "The admin username of the VM that will be deployed"
}

variable "vm_admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure"
}
