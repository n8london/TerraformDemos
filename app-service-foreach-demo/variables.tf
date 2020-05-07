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

variable "tags" {
  type = map(string)

  default = {
    Owner       = "admin@contoso.ac.uk"
    DoNotRemove = "True"
  }
}
variable "webapps" {
  description = "Names for Web apps"
  type        = map
  default = {
    web1 = "fe-web-1"
    #web2 = "be-web-2"
    #web3 = "demo-web-3"
  }
}