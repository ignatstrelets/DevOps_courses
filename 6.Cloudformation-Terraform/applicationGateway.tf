provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "web" {
  name     = "web-resources"
  location = "israelcentral"
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "vnet01"
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "subnet0" {
  name                 = "subnet0"
  resource_group_name  = azurerm_resource_group.web.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.254.0.0/24"]
}

resource "azurerm_application_gateway" "appgw01" {
  name                = "example-appgateway"
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.subnet0.id
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "http_conf"
    private_ip_address_allocation = "Dynamic"
  }

  backend_address_pool {
    name = "backend_address_pool"
  }

  backend_http_settings {
    name                  = "http_settings"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "http_conf"
    frontend_port_name             = "http"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing_rule"
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "backend_address_pool"
    backend_http_settings_name = "http_settings"
  }
}

