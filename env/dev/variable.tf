variable "resource_groups" {

  type = map(object({

    name = string

    location = string

  }))

}

variable "vnets" {

  type = map(object({

    name = string

    location = string

    resource_group_name = string

    address_space = list(string)

  }))

}

variable "subnets" {

  type = map(object({

    name = string

    resource_group_name = string

    virtual_network_name = string

    address_prefixes = list(string)

  }))

}

variable "nsgs" {

  type = map(object({

    name = string

    location = string

    resource_group_name = string

  }))

}

variable "nsg_rules" {

  type = map(object({

    name = string

    priority = number

    direction = string

    access = string

    protocol = string

    source_port_range = string

    destination_port_range = string

    source_address_prefix = string

    destination_address_prefix = string

    resource_group_name = string

    network_security_group_name = string

  }))

}

variable "public_ips" {

  type = map(object({

    name = string

    location = string

    resource_group_name = string

    allocation_method = string

    sku = string

  }))

}

variable "storage_accounts" {

  type = map(any)

}

variable "storage_containers" {

  type = map(any)

}

variable "file_shares" {

  type = map(any)

}

variable "key_vaults" {

  type = map(any)

}

variable "route_tables" {

  type = map(any)

}

variable "routes" {

  type = map(any)

}

variable "private_dns_zones" {

  type = map(any)

}

variable "dns_links" {

  type = map(any)

}

variable "load_balancers" {

  type = map(any)

}

variable "backend_pools" {

  type = map(any)

}

variable "health_probes" {

  type = map(any)

}

variable "lb_rules" {

  type = map(any)

}

variable "outbound_rules" {

  type = map(any)

}

# variable "application_gateways" {

#   type = map(any)

# }
