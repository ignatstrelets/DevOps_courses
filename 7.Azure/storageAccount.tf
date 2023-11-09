resource "azurerm_resource_group" "main" {
  name     = "windows-resources"
  location =  "westus3"
}

resource "azurerm_virtual_network" "main" {
  name                = "windows-network"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_network_interface" "main" {
  name                = "main"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}
  resource "azurerm_windows_virtual_machine" "win-server" {
    name                = "win-server"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    size                = "Standard_B1S"
    admin_username      = "adminuser"
    admin_password      = "P@$$w0rd1234!"

    network_interface_ids = [
      azurerm_network_interface.main.id,
    ]

    os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
  }

resource "azurerm_storage_account" "corpstorage01" {
  name                     = "corpstorage01"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier = "Hot"
######################################
# Unable to set "account_kind = BlobStorage" due to unknown bug ("no such host")
######################################
  enable_https_traffic_only = true
}


resource "azurerm_storage_share" "corpstorage01share" {
  name = "corpstorage01share"
  storage_account_name = azurerm_storage_account.corpstorage01.name
  quota = 10
  depends_on           = [azurerm_storage_account.corpstorage01]
  acl {
    id = "f22d4938-ece8-45fc-9cab-44e6f3d4dbcd"
    access_policy {
      permissions = "rwl"
    }
  }
}

output "access_key" {
  sensitive = true
  value = azurerm_storage_account.corpstorage01.primary_access_key
}


