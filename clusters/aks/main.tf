provider "azurerm" {
  features {}
  client_id = var.appId
  client_secret = var.password
  tenant_id = var.tenant
  subscription_id = var.subscription
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "acmdemo-aks-${random_string.suffix.result}"
}