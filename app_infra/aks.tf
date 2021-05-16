provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name
    dns_prefix          = "${azurerm_resource_group.k8s.name}-cluster"
    

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    default_node_pool {
        name            = "agentpool"
        node_count      = var.agent_count
        vm_size         = "Standard_D2_v2"
        type            = "VirtualMachineScaleSets"
        vnet_subnet_id  = azurerm_subnet.internal.id
    }

    identity {
        type = "SystemAssigned"
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "azure"
    }

    tags = {
        Environment = "Mediawiki"
    }
}
