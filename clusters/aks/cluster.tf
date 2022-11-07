
resource "azurerm_resource_group" "default" {
  name     = "${random_string.suffix.result}-rg"
  location = "West US 2"

  tags = {
    environment = "Demo"
  }
}
