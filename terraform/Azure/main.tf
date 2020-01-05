
resource "azurerm_resource_group" "es-group" {
  name = "EsResourceGroup"
  location = "North Europe"

  tags = {
      Owner = "Tiago Ramalho"
  }
}

variable "prefix" {
  default = "es"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.es-group.location}"
  resource_group_name = "${azurerm_resource_group.es-group.name}"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.es-group.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = "${azurerm_resource_group.es-group.location}"
  resource_group_name = "${azurerm_resource_group.es-group.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.es-stormcrawler-pip.id}"
  }
}

resource "azurerm_public_ip" "es-stormcrawler-pip" {
  name                = "es-stormcrawler-pip"
  resource_group_name = "${azurerm_resource_group.es-group.name}"
  location            = "${azurerm_resource_group.es-group.location}"
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "es-security" {
  name                = "es-security-group"
  location            = "${azurerm_resource_group.es-group.location}"
  resource_group_name = "${azurerm_resource_group.es-group.name}"

  security_rule {
    name                       = "es-stormcrawler"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Owner = "Tiago Ramalho"
  }
}
resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = "${azurerm_resource_group.es-group.location}"
  resource_group_name   = "${azurerm_resource_group.es-group.name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_D2s_v3"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 128
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    Owner = "Tiago Ramalho"
  }

    os_profile {
    computer_name  = "es-stormcrawler-vm"
    admin_username = "<username>"
    admin_password = "<password>"
    custom_data = "${file("minimal_install.sh")}"
  }
}