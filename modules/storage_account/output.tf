output "storage_account_ids" {
  value = {
    for k, v in azurerm_storage_account.sa :
    k => v.id
  }
}

output "storage_account_names" {
  value = {
    for k, v in azurerm_storage_account.sa :
    k => v.name
  }
}

output "primary_blob_endpoints" {
  value = {
    for k, v in azurerm_storage_account.sa :
    k => v.primary_blob_endpoint
  }
}

output "primary_access_keys" {
  value = {
    for k, v in azurerm_storage_account.sa :
    k => v.primary_access_key
  }

  sensitive = true
}