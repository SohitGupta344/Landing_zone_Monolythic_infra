resource "azurerm_private_endpoint" "pe" {

  for_each = var.private_endpoints

  name = each.value.name

  location = each.value.location

  resource_group_name = each.value.resource_group_name

  subnet_id = each.value.subnet_id

  private_service_connection {

    name = "${each.value.name}-connection"

    private_connection_resource_id = each.value.private_connection_resource_id

    subresource_names = each.value.subresource_names

    is_manual_connection = false

  }

}