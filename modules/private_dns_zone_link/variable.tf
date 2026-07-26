variable "dns_links" {

  type = map(object({

    name = string

    resource_group_name = string

    private_dns_zone_name = string

    virtual_network_id = string

  }))

}