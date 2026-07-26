output "peering_ids" {

  value = {

    for k,v in azurerm_virtual_network_peering.peering :

    k => v.id

  }

}