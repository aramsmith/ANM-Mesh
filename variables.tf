#######################
#   Project 
#######################
variable "project" {
  description = "Please provide project name for reference"
  default = "ANM-Demo"
}

#######################
# RG name
#######################
variable "resource_group_name" {
  description = "Please provide Resource Group name"
  default     = "ANM-Mesh"
}

#######################
#Locations
#######################
variable "location1" {
  description = "Location to deploy resources"
  default     = "eastus"
}

variable "location2" {
  description = "Location to deploy resources"
  default     = "eastus2"
}

variable "location3" {
  description = "Location to deploy resources"
  default     = "westus"
}

#######################
# Networking vars
#######################

##WL1-VNet10##
variable "vnet1" {
    description = "Provide vnet "
    default     = ["10.10.0.0/16",]
    }

variable "vnet1name" {
  description = "Provide Vnet1 name"
  default = "Wl1-VNet10"
}

variable "vnet1_subnet" {
    description = "Provide VM Subnet "
    default     = ["10.10.0.0/24",]
   }

variable "vnet1subnetname" {
  description = "Provide Vnet1 subnet name"
  default = "Infra-Vnet10"
}

variable "bastion_subnet" {
    description = "Provide Bastion Subnet "
    default     = ["10.10.1.0/27",]
}

variable "bastionname" {
    description = "Provide Bastion name "
    default     = "WL1-Bastion"
}

##WL2-VNet11##
variable "vnet2" {
    description = "Provide vnet "
    default     = ["10.11.0.0/16",]
    }

variable "vnet2name" {
  description = "Provide Vnet2 name"
  default = "Wl2-VNet11"
}

variable "vnet2_subnet" {
    description = "Provide VM Subnet "
    default     = ["10.11.0.0/24",]
   }

variable "vnet2subnetname" {
  description = "Provide Vnet2 subnet name"
  default = "Infra-Vnet11"
}
##WL3-VNet12##
variable "vnet3" {
    description = "Provide vnet "
    default     = ["10.12.0.0/16",]
    }

variable "vnet3name" {
  description = "Provide Vnet3 name"
  default = "Wl3-VNet12"
}

variable "vnet3_subnet" {
    description = "Provide VM Subnet "
    default     = ["10.12.0.0/24",]
   }

variable "vnet3subnetname" {
  description = "Provide Vnet3 subnet name"
  default = "Infra-Vnet12"
}

######################
# VM Vars
######################
variable "admin_username" {
  description = "Please provide admin username"
  default = "AzureAdmin"
}

variable "admin_password" {
  description = "Please provide Password, must adhere to azure password complexity"
  type =  string
}

variable "vm1name" {
  description = "Please provide the machine name for VM1"
  default = "WL1VM1"
}

variable "vm2name" {
  description = "Please provide the machine name for VM1"
  default = "WL2VM1"
}

variable "vm3name" {
  description = "Please provide the machine name for VM1"
  default = "WL3VM1"
}

variable "vmsize" {
  description = "Size of the VMs"
  default     = "Standard_D2_v4"
}

