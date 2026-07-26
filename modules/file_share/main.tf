resource "azurerm_storage_share" "share" {

  for_each = var.file_shares

  name = each.value.name

  storage_account_id = each.value.storage_account_id

  quota = each.value.quota

}