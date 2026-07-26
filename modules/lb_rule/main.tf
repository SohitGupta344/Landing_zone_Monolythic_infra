resource "azurerm_lb_rule" "rule" {

  for_each = var.lb_rules

  name                           = each.value.name

  loadbalancer_id                = each.value.loadbalancer_id

  protocol                       = each.value.protocol

  frontend_port                  = each.value.frontend_port

  backend_port                   = each.value.backend_port

  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name

  backend_address_pool_ids       = each.value.backend_address_pool_ids

  probe_id                       = each.value.probe_id

  disable_outbound_snat            = true

}