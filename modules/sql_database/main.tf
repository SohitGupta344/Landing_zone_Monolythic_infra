resource "azurerm_mssql_database" "db" {

  for_each = var.sql_databases

  name = each.value.name

  server_id = each.value.server_id

  sku_name = each.value.sku_name

}