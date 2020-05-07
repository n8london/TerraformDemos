provider "azurerm" {
  version = "=1.28.0"
}

resource "random_string" "unique" {
  length  = 5
  special = false
  number  = false
}

resource "azurerm_resource_group" "rg" {
  name     = join("", [var.resourcegroup,var.environment, "-rg"])
  location = var.location
  tags = merge(
    {
      "CreatedDate" = substr(timestamp(), 0, 10)
    },
    var.tags,
  )
}

resource "azurerm_app_service_plan" "asp" {
  name                = join("", [var.environment, "-", random_string.unique.result])
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Free"
    size = "F1"
  }
  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_app_service" "webapp" {
  #count               = azurerm_app_service_plan.main.sku[0].tier == "Free" ? 1 : 2
  count               = var.webappcount
  name                = join("", [var.environment, "-WebApp-", count.index])
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  tags = merge(
    {
      "CreatedDate" = substr(timestamp(), 0, 10)
    },
    var.tags,
  )
  depends_on = [azurerm_app_service_plan.asp]
}

