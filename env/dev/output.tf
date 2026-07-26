output "rg_ids" {

  value = module.resource_group.rg_ids

}

output "rg_names" {

  value = module.resource_group.rg_names

}

output "vnet_ids" {

  value = module.virtual_network.vnet_ids

}

output "vnet_names" {

  value = module.virtual_network.vnet_names

}

output "subnet_ids" {

  value = module.subnet.subnet_ids

}

output "subnet_names" {

  value = module.subnet.subnet_names

}

output "nsg_ids" {

  value = module.nsg.nsg_ids

}

output "nsg_names" {

  value = module.nsg.nsg_names

}

output "association_ids" {

  value = module.subnet_nsg_association.association_ids

}

output "public_ip_ids" {

  value = module.public_ip.public_ip_ids

}

output "vm_ids" {

  value = module.virtual_machine.vm_ids

}

output "nic_ids" {

  value = module.virtual_machine.nic_ids

}

output "bastion_ids" {

  value = module.bastion.bastion_ids

}

output "peering_ids" {

  value = module.vnet_peering.peering_ids

}

output "storage_account_ids" {

  value = module.storage_account.storage_account_ids

}

output "container_ids" {

  value = module.storage_container.container_ids

}

output "share_ids" {

  value = module.file_share.share_ids

}

output "key_vault_ids" {

  value = module.key_vault.key_vault_ids

}

output "sql_server_ids" {

  value = module.sql_server.sql_server_ids

}

output "database_ids" {

  value = module.sql_database.database_ids

}

output "route_table_ids" {

  value = module.route_table.route_table_ids

}

output "route_ids" {

  value = module.route.route_ids

}

output "subnet_route_association_ids" {

  value = module.subnet_route_association.association_ids

}

output "private_dns_zone_ids" {

  value = module.private_dns_zone.dns_zone_ids

}

output "dns_link_ids" {

  value = module.private_dns_zone_link.dns_link_ids

}

output "private_endpoint_ids" {

  value = module.private_endpoint.private_endpoint_ids

}

output "lb_ids" {

  value = module.load_balancer.lb_ids

}

output "lb_names" {

  value = module.load_balancer.lb_names

}

output "backend_pool_ids" {

  value = module.backend_pool.backend_pool_ids

}

output "backend_pool_association_ids" {

  value = module.backend_pool_nic_association.association_ids

}

output "probe_ids" {

  value = module.health_probe.probe_ids

}

output "probe_names" {

  value = module.health_probe.probe_names

}

output "lb_rule_ids" {

  value = module.lb_rule.lb_rule_ids

}

output "lb_rule_names" {

  value = module.lb_rule.lb_rule_names

}

output "outbound_rule_ids" {

  value = module.outbound_rule.outbound_rule_ids

}

output "outbound_rule_names" {

  value = module.outbound_rule.outbound_rule_names

}

# output "appgw_ids" {

#   value = module.application_gateway.appgw_ids

# }

# output "appgw_names" {

#   value = module.application_gateway.appgw_names

# }