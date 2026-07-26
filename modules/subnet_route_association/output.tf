output "association_ids" {

  value = {

    for k,v in azurerm_subnet_route_table_association.association :

    k => v.id

  }

}