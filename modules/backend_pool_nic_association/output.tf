output "association_ids" {

  value = {

    for k,v in azurerm_network_interface_backend_address_pool_association.association :

    k => v.id

  }

}