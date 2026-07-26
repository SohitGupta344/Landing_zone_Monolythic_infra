variable "passwords" {

  type = map(object({

    length = number

  }))

}