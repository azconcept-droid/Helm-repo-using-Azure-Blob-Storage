# Return storage account access key

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.helmchartgroup.primary_access_key
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.helmchartgroup.name
  sensitive = false
}

output "storage_container_name" {
  value = azurerm_storage_container.helmchartgroup.name
  sensitive = false
}
