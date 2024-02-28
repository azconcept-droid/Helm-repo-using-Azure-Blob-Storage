# Return storage account access key

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.helmchart.primary_access_key
  sensitive = true
}
