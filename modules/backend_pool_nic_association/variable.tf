variable "nic_associations" {

  type = map(object({

    nic_id = string

    ip_configuration_name = string

    backend_pool_id = string

  }))

}