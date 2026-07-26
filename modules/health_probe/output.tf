output "probe_ids" {

  value = {

    for k,v in azurerm_lb_probe.probe :

    k => v.id

  }

}

output "probe_names" {

  value = {

    for k,v in azurerm_lb_probe.probe :

    k => v.name

  }

}