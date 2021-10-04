#######################################################################
## Create Workload 3
## 1 - Create Virtual Network
## 2 - Create subnets
## 3 - deploy VM omn subnet Infra
#######################################################################

## 1 ##
resource "azurerm_virtual_network" "wl3vnet30" {
  name                = var.vnet3name
  location            = var.location3
  resource_group_name = azurerm_resource_group.anmmesh.name
  address_space       = var.vnet3
  
   tags = {
    environment = var.project
    deployment  = var.vnet3name
    location = var.location3
   }
}

##2##
resource "azurerm_subnet" "vnet3_subnet" {
  name                 = var.vnet3subnetname
  resource_group_name  = azurerm_resource_group.anmmesh.name
  virtual_network_name = azurerm_virtual_network.wl3vnet30.name
  address_prefixes     = var.vnet3_subnet
}

##3##
##NIC##
resource "azurerm_network_interface" "vm3nic" {
  name                 = "${var.vm3name}-nic"
  location             = var.location3
  resource_group_name  = azurerm_resource_group.anmmesh.name
  
  ip_configuration {
    name                          = "${var.vm3name}-nic-ip"
    subnet_id                     = azurerm_subnet.vnet3_subnet.id
    private_ip_address_allocation = "Dynamic"
    }
}

##VM##
resource "azurerm_virtual_machine" "WL3VM1" {
  name                  = var.vm3name
  resource_group_name = var.resource_group_name
  location              = var.location3
  network_interface_ids = [azurerm_network_interface.vm3nic.id]
  vm_size               = var.vmsize
 
   storage_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm3name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm3name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}