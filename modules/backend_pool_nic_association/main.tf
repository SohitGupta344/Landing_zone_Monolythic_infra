resource "azurerm_network_interface_backend_address_pool_association" "association" {

  for_each = var.nic_associations

  network_interface_id = each.value.nic_id

  ip_configuration_name = each.value.ip_configuration_name

  backend_address_pool_id = each.value.backend_pool_id

}