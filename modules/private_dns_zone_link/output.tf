output "dns_link_ids" {

  value = {

    for k,v in azurerm_private_dns_zone_virtual_network_link.link :

    k => v.id

  }

}