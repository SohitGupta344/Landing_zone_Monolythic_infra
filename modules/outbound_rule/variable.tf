variable "outbound_rules" {

  type = map(object({

    name = string

    loadbalancer_id = string

    protocol = string

    backend_address_pool_id = string

    frontend_ip_configuration_name = string

  }))

}