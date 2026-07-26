variable "virtual_machines" {

  type = map(object({

    vm_name = string

    nic_name = string

    location = string

    rg_name = string

    subnet_id = string

    vm_size = string

    admin_username = string

    # admin_password = string

    public_key_path = string

  }))

}