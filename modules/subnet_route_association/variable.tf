variable "subnet_route_associations" {

  type = map(object({

    subnet_id      = string
    route_table_id = string

  }))

}