resource "azurerm_lb_outbound_rule" "outbound" {

  for_each = var.outbound_rules

  name = each.value.name

  loadbalancer_id = each.value.loadbalancer_id

  protocol = each.value.protocol

  backend_address_pool_id = each.value.backend_address_pool_id

  frontend_ip_configuration {

    name = each.value.frontend_ip_configuration_name

  }

}