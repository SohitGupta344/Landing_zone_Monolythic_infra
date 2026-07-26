variable "nsgs" {

  description = "Network Security Group Configuration"

  type = map(object({

    name                = string

    location            = string

    resource_group_name = string

  }))

}