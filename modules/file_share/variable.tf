variable "file_shares" {

  type = map(object({

    name = string

    storage_account_id = string

    quota = number

  }))

}