output "lb_ids" {

  value = {

    for k,v in azurerm_lb.lb :

    k => v.id

  }

}

output "lb_names" {

  value = {

    for k,v in azurerm_lb.lb :

    k => v.name

  }

}

output "frontend_ip_names" {

  value = {

    for k,v in azurerm_lb.lb :

    k => v.frontend_ip_configuration[0].name

  }

}