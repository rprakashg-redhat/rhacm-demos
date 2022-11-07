provider "azurerm" {
  features {}
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "acmdemo-aks-${random_string.suffix.result}"
}