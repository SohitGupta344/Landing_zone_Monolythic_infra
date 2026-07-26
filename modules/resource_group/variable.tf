variable "resource_groups" {

  description = "Resource Groups"

  type = map(object({

    name     = string

    location = string

  }))

}