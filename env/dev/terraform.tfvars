resource_groups = {

  rg1 = {

    name = "mohit-rg"

    location = "Central India"

  }

}

vnets = {

  vnet1 = {

    name = "frontend-vnet"

    location = "Central India"

    resource_group_name = "mohit-rg"

    address_space = ["10.0.0.0/16"]

  }

  vnet2 = {

    name = "backend-vnet"

    location = "Central India"

    resource_group_name = "mohit-rg"

    address_space = ["10.1.0.0/16"]

  }

}

subnets = {

  frontend_subnet = {

    name = "frontend-subnet"

    resource_group_name = "mohit-rg"

    virtual_network_name = "frontend-vnet"

    address_prefixes = ["10.0.1.0/24"]

  }

  backend_subnet = {

    name = "backend-subnet"

    resource_group_name = "mohit-rg"

    virtual_network_name = "frontend-vnet"

    address_prefixes = ["10.0.2.0/24"]

  }

  bastion_subnet = {

    name = "AzureBastionSubnet"

    resource_group_name = "mohit-rg"

    virtual_network_name = "frontend-vnet"

    address_prefixes = ["10.0.10.0/26"]

  }

  appgw_subnet = {

    name = "ApplicationGatewaySubnet"

    resource_group_name = "mohit-rg"

    virtual_network_name = "frontend-vnet"

    address_prefixes = ["10.0.3.0/24"]

  }

}

nsgs = {

  frontend_nsg = {

    name = "frontend-nsg"

    location = "Central India"

    resource_group_name = "mohit-rg"

  }

  backend_nsg = {

    name = "backend-nsg"

    location = "Central India"

    resource_group_name = "mohit-rg"

  }

}

nsg_rules = {

  frontend_ssh = {

    name = "Allow-SSH-Frontend"

    priority = 100

    direction = "Inbound"

    access = "Allow"

    protocol = "Tcp"

    source_port_range = "*"

    destination_port_range = "22"

    source_address_prefix = "*"

    destination_address_prefix = "*"

    resource_group_name = "mohit-rg"

    network_security_group_name = "frontend-nsg"

  }

  backend_ssh = {

    name = "Allow-SSH-Backend"

    priority = 110

    direction = "Inbound"

    access = "Allow"

    protocol = "Tcp"

    source_port_range = "*"

    destination_port_range = "22"

    source_address_prefix = "*"

    destination_address_prefix = "*"

    resource_group_name = "mohit-rg"

    network_security_group_name = "backend-nsg"

  }

}

public_ips = {

  bastion_pip = {

    name = "bastion-pip"

    location = "Central India"

    resource_group_name = "mohit-rg"

    allocation_method = "Static"

    sku = "Standard"

  }

  lb_pip = {
    name                = "lb-pip"
    location            = "Central India"
    resource_group_name = "mohit-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

}

storage_accounts = {

  sa1 = {

    name = "sohitstorage001"

    resource_group_name = "mohit-rg"

    location = "Central India"

    account_tier = "Standard"

    account_replication_type = "LRS"

  }

}

storage_containers = {

  container1 = {

    name = "tfstate"

    storage_account_id = ""

    container_access_type = "private"

  }

}

file_shares = {

  share1 = {

    name = "sharedfiles"

    storage_account_id = ""

    quota = 50

  }

}

key_vaults = {

  kv1 = {

    name = "sohitkv001"

    location = "Central India"

    resource_group_name = "mohit-rg"

    tenant_id = "a7dd8b02-fc7e-452c-9b2c-c53db150afd2"

    sku_name = "standard"

  }

}

route_tables = {

  frontend_rt = {

    name = "frontend-rt"

    location = "Central India"

    resource_group_name = "mohit-rg"

  }

  backend_rt = {

    name = "backend-rt"

    location = "Central India"

    resource_group_name = "mohit-rg"

  }

}

routes = {

  frontend_default = {

    name = "default-route"

    resource_group_name = "mohit-rg"

    route_table_name = "frontend-rt"

    address_prefix = "0.0.0.0/0"

    next_hop_type = "Internet"

  }

  backend_default = {

    name = "default-route"

    resource_group_name = "mohit-rg"

    route_table_name = "backend-rt"

    address_prefix = "0.0.0.0/0"

    next_hop_type = "Internet"

  }

}

private_dns_zones = {

  storage = {

    name = "privatelink.blob.core.windows.net"

    resource_group_name = "mohit-rg"

  }

  sql = {

    name = "privatelink.database.windows.net"

    resource_group_name = "mohit-rg"

  }

}


dns_links = {

  storage_link = {

    name = "storage-link"

    resource_group_name = "mohit-rg"

    private_dns_zone_name = "privatelink.blob.core.windows.net"

  }

  sql_link = {

    name = "sql-link"

    resource_group_name = "mohit-rg"

    private_dns_zone_name = "privatelink.database.windows.net"

  }

}

load_balancers = {

  lb1 = {

    name = "frontend-lb"

    location = "Central India"

    resource_group_name = "mohit-rg"

    sku = "Standard"

    frontend_ip_name = "frontend-ip"

  }

}

backend_pools = {

  pool1 = {

    name = "backend-pool"

  }

}

health_probes = {

  ssh_probe = {

    name = "ssh-probe"

    protocol = "Tcp"

    port = 22

  }

  http_probe = {

    name = "http-probe"

    protocol = "Tcp"

    port = 80

  }

}

lb_rules = {

  http_rule = {

    name = "http-rule"

    protocol = "Tcp"

    frontend_port = 80

    backend_port = 80

  }

  ssh_rule = {

    name = "ssh-rule"

    protocol = "Tcp"

    frontend_port = 22

    backend_port = 22

  }

}

outbound_rules = {

  outbound1 = {

    name = "vm-outbound-rule"

    protocol = "All"

  }

}

# application_gateways = {

#   appgw1 = {

#     name = "sohit-appgw"

#     location = "Central India"

#     resource_group_name = "mohit-rg"

#     sku_name = "Standard_v2"

#     sku_tier = "Standard_v2"

#     capacity = 2

#     frontend_port = 80

#   }

# }