output "route_ids" {

  value = {

    for k,v in azurerm_route.route :

    k => v.id

  }

}