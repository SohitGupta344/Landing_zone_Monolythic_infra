resource "azurerm_key_vault_secret" "secret" {

  for_each = var.key_vault_secrets

  name = each.value.name

  value = each.value.value

  key_vault_id = each.value.key_vault_id

  content_type = lookup(each.value, "content_type", null)

  expiration_date = lookup(each.value, "expiration_date", null)

}