
provider "azurerm" {
  # Configuration options
    features {}
    #skip_provider_registration = true
}


resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "helmchart" {
  name     = "helmchartgroup"
  location = "East US"
}

resource "azurerm_key_vault" "helmchart" {
  name                = "helmchart-key-vault"
  resource_group_name = azurerm_resource_group.helmchart.name
  location            = azurerm_resource_group.helmchart.location
  enabled_for_disk_encryption = true
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "get",
      "list",
    ]

    secret_permissions = [
      "get",
      "list",
    ]
  }
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
