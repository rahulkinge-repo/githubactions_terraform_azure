terraform {
  backend "azurerm" {
    resource_group_name  = "k8s_state_storage_resource_group_dev"
    storage_account_name = "rkterraformstatestorage"
    container_name       = "tfstatecontainer"
    key                  = "tfstatecontainer.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  features {}
}
 
data "azurerm_client_config" "current" {}
 
#Create Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "tamops"
  location = "eastus2"
}
 