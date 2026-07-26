variable "storage_containers" {

  type = map(object({

    name                  = string

    storage_account_name  = string

    container_access_type = string

  }))

}