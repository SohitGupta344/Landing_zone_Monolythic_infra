variable "lb_rules" {

  type = map(object({

    name = string

    loadbalancer_id = string

    frontend_ip_configuration_name = string

    backend_address_pool_ids = list(string)

    probe_id = string

    protocol = string

    frontend_port = number

    backend_port = number

  }))

}