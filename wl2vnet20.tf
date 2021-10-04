#######################################################################
## Create Workload 2
## 1 - Create Virtual Network
## 2 - Create subnets
## 3 - deploy VM omn subnet Infra
#######################################################################

## 1 ##
resource "azurerm_virtual_network" "wl2vnet20" {
  name                = var.vnet2name
  location            = var.location2
  resource_group_name = azurerm_resource_group.anmmesh.name
  address_space       = var.vnet2
  
   tags = {
    environment = var.project
    deployment  = var.vnet2name
    location = var.location2
   }
}

##2##
resource "azurerm_subnet" "vnet2_subnet" {
  name                 = var.vnet2subnetname
  resource_group_name  = azurerm_resource_group.anmmesh.name
  virtual_network_name = azurerm_virtual_network.wl2vnet20.name
  address_prefixes     = var.vnet2_subnet
}

##3##
##NIC##
resource "azurerm_network_interface" "vm2nic" {
  name                 = "${var.vm2name}-nic"
  location             = var.location2
  resource_group_name  = azurerm_resource_group.anmmesh.name
  
  ip_configuration {
    name                          = "${var.vm2name}-nic-ip"
    subnet_id                     = azurerm_subnet.vnet2_subnet.id
    private_ip_address_allocation = "Dynamic"
    }
}

##VM##
resource "azurerm_virtual_machine" "WL2VM1" {
  name                  = var.vm2name
  resource_group_name = var.resource_group_name
  location              = var.location2
  network_interface_ids = [azurerm_network_interface.vm2nic.id]
  vm_size               = var.vmsize
 
   storage_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm2name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm2name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}