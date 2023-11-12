terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "as-resources" {
  name     = "app-service-resources"
  location =  "westus3"
}

resource "azurerm_virtual_network" "as-net" {
  name                = "as-net"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.as-resources.location
  resource_group_name = azurerm_resource_group.as-resources.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.as-resources.name
  virtual_network_name = azurerm_virtual_network.as-net.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_service_plan" "web-sp" {
  name                = "web-sp"
  resource_group_name = azurerm_resource_group.as-resources.name
  location            = azurerm_resource_group.as-resources.location
  os_type             = "Linux"
  sku_name            = "S1"

}

resource "azurerm_linux_web_app" "webapp01ignat" {
  location = azurerm_resource_group.as-resources.location
  name = "webapp01ignat"
  resource_group_name = azurerm_resource_group.as-resources.name
  service_plan_id = azurerm_service_plan.web-sp.id
  site_config {}
}