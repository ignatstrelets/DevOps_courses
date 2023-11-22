resource "azurerm_resource_group" "main" {
  name     = "ubuntu-resources"
  location =  "israelcentral"
}

resource "azurerm_virtual_network" "main" {
  name                = "ubuntu-network"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vm-1" {
  name                = "vm-1-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "vm-2" {
  name                = "vm-2-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "VMLU01" {
  name                            = "VMLU01"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = ""
  disable_password_authentication = false
  network_interface_ids           = [
    azurerm_network_interface.vm-1.id
  ]
  os_disk {
    caching              = "None"
    storage_account_type = "StandardSSD_LRS"
  }
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "VMLU02" {
  name                            = "VMLU02"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = ""
  disable_password_authentication = false
  network_interface_ids           = [
    azurerm_network_interface.vm-2.id
  ]
  os_disk {
    caching              = "None"
    storage_account_type = "StandardSSD_LRS"
  }
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_availability_set" "main" {
  location            = azurerm_resource_group.main.location
  name                = "main"
  resource_group_name = azurerm_resource_group.main.name
  platform_fault_domain_count = 2
}

