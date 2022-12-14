
terraform {
  backend "azurerm" {
    subscription_id = "a9f9fd7b-4578-420c-abe1-833dc95ab730"
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "storageacctrk199991"
    container_name       = "storageacctrangacontainer1"
    key                  = "kubernetes-dev.tfstate"
  }
}
 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
 
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group}_${var.environment}"
  location = var.location
}


resource "azurerm_kubernetes_cluster" "terraform-k8s" {
  name                = "${var.cluster_name}_${var.environment}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.node_count
    vm_size         = "standard_b2ms"
    # vm_size         = "standard_d2as_v5"      CHANGE IF AN ERROR ARISES 
  }

  service_principal {
    client_id     = "91c27291-cf9c-48ad-8bf0-8b62c48010bd"
    client_secret = var.client_secret
  }

  tags = {
    Environment = var.environment
  }
}


