variable "key_vault_secrets" {

  type = map(object({

    name         = string

    value        = string

    key_vault_id = string

    content_type    = optional(string)

    expiration_date = optional(string)

  }))

}