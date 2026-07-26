# output "appgw_ids" {

#   value = {

#     for k,v in azurerm_application_gateway.appgw :

#     k => v.id

#   }

# }

# output "appgw_names" {

#   value = {

#     for k,v in azurerm_application_gateway.appgw :

#     k => v.name

#   }

# }