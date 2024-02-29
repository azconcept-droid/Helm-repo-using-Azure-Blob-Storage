# Create Azure Blob Storage

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "helmchart" {
  name     = "helmchartgroup"
  location = "East US"
}

resource "azurerm_storage_account" "helmchartgroup" {
  name                     = "helmstorage${random_string.resource_code.result}"
  # name                     = "helmstoragepdiol"
  resource_group_name      = azurerm_resource_group.helmchart.name
  location                 = azurerm_resource_group.helmchart.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "GRS"

  tags = {
	environment = "production"
  }
}

resource "azurerm_storage_container" "helmchartgroup" {
  name                  = "helm-chart-container"
  storage_account_name  = azurerm_storage_account.helmchartgroup.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "helmchartgroup" {
  name                   = "helm-blob"
  storage_account_name   = azurerm_storage_account.helmchartgroup.name
  storage_container_name = azurerm_storage_container.helmchartgroup.name
  type                   = "Block"
  source                 = "./index.html"
}
