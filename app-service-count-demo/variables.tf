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

variable "webappcount" {
  default = "1"
}
