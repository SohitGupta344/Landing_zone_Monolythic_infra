output "lb_rule_ids" {

  value = {

    for k,v in azurerm_lb_rule.rule :

    k => v.id

  }

}

output "lb_rule_names" {

  value = {

    for k,v in azurerm_lb_rule.rule :

    k => v.name

  }

}