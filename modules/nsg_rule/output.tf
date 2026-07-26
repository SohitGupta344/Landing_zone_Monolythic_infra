output "rule_ids" {

  value = {

    for k,v in azurerm_network_security_rule.rule :

    k => v.id

  }

}