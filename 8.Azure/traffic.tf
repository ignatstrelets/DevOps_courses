resource "azurerm_resource_group" "web" {
  name     = "web-resources"
  location = "israelcentral"
}

resource "azurerm_virtual_network" "web01-vnet" {
  name                = "web01-vnet"
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "web01-subnet" {
  name                 = "web01-subnet"
  resource_group_name  = azurerm_resource_group.web.name
  virtual_network_name = azurerm_virtual_network.web01-vnet.name
  address_prefixes     = ["10.254.0.0/24"]
}

resource "azurerm_public_ip" "web01-pub-ip" {
  allocation_method   = "Dynamic"
  location            = azurerm_resource_group.web.location
  name                = "public-ip"
  resource_group_name = azurerm_resource_group.web.name
}

resource "azurerm_network_interface" "web01-nic" {
  name                = "web01-nic"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name

  ip_configuration {
    name                          = "testconfiguration1"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.web01-subnet.id
    public_ip_address_id = azurerm_public_ip.web01-pub-ip.id
  }
}

resource "azurerm_network_security_group" "web-sg" {
  name                = "web-sg"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name

  security_rule {
    name                       = "allow-https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "deny-http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_machine" "web01" {
  name                  = "web01"
  location              = azurerm_resource_group.web.location
  resource_group_name   = azurerm_resource_group.web.name
  network_interface_ids = [azurerm_network_interface.web01-nic.id]
  vm_size               = "Standard_B1s"
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "ignat"
    admin_password = ""
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.web01-nic.id
  network_security_group_id = azurerm_network_security_group.web-sg.id
}


