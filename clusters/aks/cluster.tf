resource "azurerm_kubernetes_cluster" "default" {
  name                = local.cluster_name
  location            = var.region
  resource_group_name = var.resourcegroup
  dns_prefix          = "${random_string.suffix.result}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }
  
  tags = {
    environment = "Demo"
  }
}
