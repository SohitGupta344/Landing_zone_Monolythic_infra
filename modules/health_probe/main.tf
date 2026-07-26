resource "azurerm_lb_probe" "probe" {

  for_each = var.health_probes

  name = each.value.name

  loadbalancer_id = each.value.loadbalancer_id

  protocol = each.value.protocol

  port = each.value.port

  interval_in_seconds = try(
    each.value.interval_in_seconds,
    5
  )

  number_of_probes = try(
    each.value.number_of_probes,
    2
  )

  request_path = try(
    each.value.request_path,
    null
  )

}