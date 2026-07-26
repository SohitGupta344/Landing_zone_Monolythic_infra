variable "sql_databases" {

  type = map(object({

    name = string

    server_id = string

    sku_name = string

  }))

}