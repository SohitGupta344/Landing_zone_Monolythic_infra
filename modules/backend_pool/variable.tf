variable "backend_pools" {

  type = map(object({

    name = string

    loadbalancer_id = string

  }))

}