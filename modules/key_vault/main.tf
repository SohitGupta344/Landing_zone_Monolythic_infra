data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {

  for_each = var.key_vaults

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tenant_id = each.value.tenant_id

  sku_name = each.value.sku_name

  purge_protection_enabled   = false

  soft_delete_retention_days = 7

  access_policy {

    tenant_id = data.azurerm_client_config.current.tenant_id

    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [

      "Get",
      "List",
      "Set",
      "Delete"

    ]

  }

}