variable "resourcegroup" {
  type    = string
  default = "terraform-demos-"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "public_ip" {
  type    = string
  default = "false"
}
