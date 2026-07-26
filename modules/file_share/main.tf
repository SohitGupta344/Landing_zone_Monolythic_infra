resource "azurerm_storage_share" "share" {

  for_each = var.file_shares

  name = each.value.name

  storage_account_name = each.value.storage_account_name

  quota = each.value.quota

}