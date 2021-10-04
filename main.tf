provider "azurerm" {
   features{}
}

#######################################################################
## Create Resource Group
#######################################################################

resource "azurerm_resource_group" "anmmesh" {
  name     = var.resource_group_name
  location = var.location1

  tags = {
    environment = var.project
    deployment  = "terraform"
    environment = var.resource_group_name
    }
}

resource "azurerm_log_analytics_workspace" "anmmesh" {
  name                = "anm-mesh-log-workspace"
  location            = var.location1
  resource_group_name  = azurerm_resource_group.anmmesh.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
 }
