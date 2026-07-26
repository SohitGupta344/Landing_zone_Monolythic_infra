output "outbound_rule_ids" {

  value = {

    for k,v in azurerm_lb_outbound_rule.outbound :

    k => v.id

  }

}

output "outbound_rule_names" {

  value = {

    for k,v in azurerm_lb_outbound_rule.outbound :

    k => v.name

  }

}