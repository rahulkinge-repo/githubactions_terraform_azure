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
      key_data = "AAAAB3NzaC1yc2EAAAADAQABAAACAQDJSUSvzhn3SQi+AZXJz1tWjQQ5VrOuvM1Qgw6m+bB/9F3QsheEhPVq5j4giYm5ekyxXgJ4D+zefBJq0GxfUCaZEqt5fYTb0AZCBJYIaUEsuO38fwTFm0ZdlNwwsfsOvy9GA76CMDOa58x9MjSs8DSzGCJ0wfYdFbVxDqfWQtfEUlST+aT7r+DfqPiUe9dR+osc66Z+q5Iop4loXx46gEhxvY3JXFfyrLtG6osZXPNLlIeFP6JmE5gajD9wMc4qN9pYTTpH4CCKL/S2CSsGXeUFmvSCF2D6ZtB+84PWdKKNcKBlbI7GKMCZYskCVGWQrVM/lpsDztEvjAiKKDr0rUsFeKjSZL0UKrloh9Oju6xT0gplL4zLQbf5hV6kniQf3gZpANjNywOOlcaj/N1dkIaQpD0cD/LtAWhKkZD/fcAifVJqz3RPvgOIm07UFwq4Fxe1HgBHXU8fIecKu2HSsvJPiDiW6K6VDCZBooG1D3xwBftgvLtoQs6ueq7N1ksCLZWQZr7CkumEeZe2th7aQ/mxCHDzlcc37YR/GSnylXczBTmftyQ2BpIOzqUBhvqevoJstK/pN49XORsgOq7mP9Ay8muTmZ5sMEgS6my4DXH6PhE0KFwhFF6POt7jVLdRv/MDMIMs/r9CeJ80I9HwAmq+cjbqgVYiw29DAs9WmYdTJQ=="
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.node_count
    vm_size         = "standard_b2ms"
    # vm_size         = "standard_d2as_v5"      CHANGE IF AN ERROR ARISES 
  }


  tags = {
    Environment = var.environment
  }
}


