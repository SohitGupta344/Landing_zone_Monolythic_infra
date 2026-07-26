output "association_ids" {

  value = {

    for k,v in azurerm_subnet_network_security_group_association.association :

    k => v.id

  }

}