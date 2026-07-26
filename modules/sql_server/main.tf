resource "azurerm_mssql_server" "sql" {

  for_each = var.sql_servers

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  version             = each.value.version

  administrator_login          = each.value.admin_login
  administrator_login_password = each.value.admin_password

  public_network_access_enabled = false
  minimum_tls_version           = "1.2"
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit" {

  for_each = var.sql_servers

  server_id = azurerm_mssql_server.sql[each.key].id

  storage_endpoint           = each.value.storage_endpoint
  storage_account_access_key = each.value.storage_account_access_key

  retention_in_days = 90
}