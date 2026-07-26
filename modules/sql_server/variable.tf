variable "sql_servers" {

  type = map(object({

    name                = string
    location            = string
    resource_group_name = string
    version             = string

    admin_login         = string
    admin_password      = string

    storage_endpoint           = string
    storage_account_access_key = string

  }))

}