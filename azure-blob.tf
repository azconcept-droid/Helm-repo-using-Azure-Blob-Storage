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

resource "azurerm_storage_account" "helmchart" {
  name                     = "helmstorage${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.helmchart.name
  location                 = azurerm_resource_group.helmchart.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "GRS"

  tags = {
	environment = "production"
  }
}

resource "azurerm_storage_container" "helmchart" {
  name                  = "helm-chart-container"
  storage_account_name  = azurerm_storage_account.helmchart.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "helmchart" {
  name                   = "helm-blob"
  storage_account_name   = azurerm_storage_account.helmchart.name
  storage_container_name = azurerm_storage_container.helmchart.name
  type                   = "Block"
  source                 = "https://github.com/azconcept-droid/azeezyahaya.github.io/blob/main/index.html"
}
