#######################################################################
## Create Workload 1
## 1 - Create Virtual Network
## 2 - Create subnets
## 3 - Create Bastion (only WL1)
## 4 - deploy VM omn subnet Infra
#######################################################################

## 1 ##
resource "azurerm_virtual_network" "wl1vnet10" {
  name                = var.vnet1name
  location            = var.location1
  resource_group_name = azurerm_resource_group.anmmesh.name
  address_space       = var.vnet1
  
   tags = {
    environment = var.project
    deployment  = var.vnet1name
    location = var.location1
   }
}

##2##
resource "azurerm_subnet" "vnet1_subnet" {
  name                 = var.vnet1subnetname
  resource_group_name  = azurerm_resource_group.anmmesh.name
  virtual_network_name = azurerm_virtual_network.wl1vnet10.name
  address_prefixes     = var.vnet1_subnet
}
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.anmmesh.name
  virtual_network_name = azurerm_virtual_network.wl1vnet10.name
  address_prefixes     = var.bastion_subnet
}

##3##
resource "azurerm_public_ip" "bastion-pip" {
  name                = "bastion-pip"
  location            = var.location1
  resource_group_name = azurerm_resource_group.anmmesh.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_bastion_host" "bastion-host" {
  name                = var.bastionname
  location            = var.location1
  resource_group_name = azurerm_resource_group.anmmesh.name

  ip_configuration {
    name                 = "bastion-host"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-pip.id
  }
}

##4##
##NIC##
resource "azurerm_network_interface" "vm1nic" {
  name                 = "${var.vm1name}-nic"
  location             = var.location1
  resource_group_name  = azurerm_resource_group.anmmesh.name
  
  ip_configuration {
    name                          = "${var.vm1name}-nic-ip"
    subnet_id                     = azurerm_subnet.vnet1_subnet.id
    private_ip_address_allocation = "Dynamic"
    }
}

##VM##
resource "azurerm_virtual_machine" "WL1VM1" {
  name                  = var.vm1name
  resource_group_name = var.resource_group_name
  location              = var.location1
  network_interface_ids = [azurerm_network_interface.vm1nic.id]
  vm_size               = var.vmsize
 
   storage_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm1name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm1name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}