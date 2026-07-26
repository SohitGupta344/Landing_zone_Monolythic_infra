# variable "application_gateways" {

#   type = map(object({

#     name = string

#     location = string

#     resource_group_name = string

#     sku_name = string

#     sku_tier = string

#     capacity = number

#     subnet_id = string

#     public_ip_id = string

#     frontend_port = number

#     backend_addresses = list(string)

#   }))

# }