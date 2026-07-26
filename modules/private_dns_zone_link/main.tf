resource "azurerm_private_dns_zone_virtual_network_link" "link" {

  for_each = var.dns_links

  name = each.value.name

  resource_group_name = each.value.resource_group_name

  private_dns_zone_name = each.value.private_dns_zone_name

  virtual_network_id = each.value.virtual_network_id

}