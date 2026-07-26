module "resource_group" {

  source = "../../modules/resource_group"

  resource_groups = var.resource_groups

}

module "virtual_network" {

  source = "../../modules/virtual_network"

  vnets = var.vnets

  depends_on = [

    module.resource_group

  ]

}

module "subnet" {

  source = "../../modules/subnet"

  subnets = var.subnets

  depends_on = [

  module.virtual_network, module.resource_group]

}

module "nsg" {

  source = "../../modules/nsg"

  nsgs = var.nsgs

  depends_on = [

    module.resource_group

  ]

}

module "nsg_rule" {

  source = "../../modules/nsg_rule"

  nsg_rules = var.nsg_rules

  depends_on = [

    module.nsg, module.resource_group

  ]

}

module "subnet_nsg_association" {

  source = "../../modules/subnet_nsg_association"

  subnet_nsg_associations = {

    frontend = {

      subnet_id = module.subnet.subnet_ids["frontend_subnet"]

      nsg_id = module.nsg.nsg_ids["frontend_nsg"]

    }

    backend = {

      subnet_id = module.subnet.subnet_ids["backend_subnet"]

      nsg_id = module.nsg.nsg_ids["backend_nsg"]

    }

  }

  depends_on = [

    module.subnet,

    module.nsg,

    module.resource_group

  ]

}

module "public_ip" {

  source = "../../modules/public_ip"

  public_ips = var.public_ips


  depends_on = [

    module.resource_group

  ]

}

module "virtual_machine" {

  source = "../../modules/virtual_machine"

  virtual_machines = {

    linux_vm1 = {

      vm_name = "linux-vm1"

      nic_name = "linux-vm1-nic"

      location = "Central India"

      rg_name = "mohit-rg"

      subnet_id = module.subnet.subnet_ids["frontend_subnet"]

      vm_size = "Standard_D2s_v3"

      admin_username = "azureuser"

      # admin_password = "Password@12345"

      public_key_path = "C:/Users/SOHIT GUPTA/.ssh/id_rsa.pub"

    }

    linux_vm2 = {

      vm_name = "linux-vm2"

      nic_name = "linux-vm2-nic"

      location = "Central India"

      rg_name = "mohit-rg"

      subnet_id = module.subnet.subnet_ids["backend_subnet"]

      vm_size = "Standard_D2s_v3"

      admin_username = "azureuser"

      # admin_password = "Password@12345"
      public_key_path = "C:/Users/SOHIT GUPTA/.ssh/id_rsa.pub"

    }

  }

  depends_on = [
    module.subnet_nsg_association,
    module.public_ip,
    module.nsg,
    module.resource_group,
    module.subnet,
    module.nsg_rule,
    module.virtual_network
  ]

}
module "bastion" {

  source = "../../modules/Basition"

  bastions = {

    bastion1 = {

      name = "sohit-bastion"

      location = "Central India"

      rg_name = "mohit-rg"

      subnet_id = module.subnet.subnet_ids["bastion_subnet"]

      public_ip_id = module.public_ip.public_ip_ids["bastion_pip"]

    }

  }

  depends_on = [
    module.public_ip,
    module.subnet,
    module.resource_group,
    module.virtual_network
  ]

}

module "vnet_peering" {

  source = "../../modules/peering"

  peerings = {

    vnet1_to_vnet2 = {

      name = "frontend-to-backend"

      resource_group_name = "mohit-rg"

      virtual_network_name = "frontend-vnet"

      remote_virtual_network_id = module.virtual_network.vnet_ids["vnet2"]

    }

    vnet2_to_vnet1 = {

      name = "backend-to-frontend"

      resource_group_name = "mohit-rg"

      virtual_network_name = "backend-vnet"

      remote_virtual_network_id = module.virtual_network.vnet_ids["vnet1"]

    }

  }

  depends_on = [
    module.virtual_network,
    module.resource_group
  ]
}

module "storage_account" {

  source = "../../modules/storage_account"

  storage_accounts = var.storage_accounts

  depends_on = [

    module.resource_group

  ]

}

module "storage_container" {

  source = "../../modules/storage_container"

  storage_containers = var.storage_containers

  depends_on = [

    module.storage_account, module.resource_group

  ]

}

module "file_share" {

  source = "../../modules/file_share"

  file_shares = {
    for k, v in var.file_shares :
    k => merge(
      v,
      {
        storage_account_name = module.storage_account.storage_account_names["sa1"]
      }
    )
  }

  depends_on = [
    module.storage_account
  ]
}

# data "azurerm_client_config" "current" {}

module "random_password" {

  source = "../../modules/random_password"

  passwords = {

    vm = {

      length = 16

    }

    sql = {

      length = 16

    }

  }

  depends_on = [

    module.resource_group

  ]

}

module "key_vault" {

  source = "../../modules/key_vault"

  key_vaults = var.key_vaults

  depends_on = [

    module.resource_group

  ]

}


module "key_vault_secret" {

  source = "../../modules/key_vault_secret"

  key_vault_secrets = {

    vm_password = {

      name = "vm-password"

      value = module.random_password.passwords["vm"]

      key_vault_id = module.key_vault.key_vault_ids["kv1"]

      content_type = "Password"

      expiration_date = "2027-12-31T23:59:59Z"

    }

    sql_password = {

      name = "sql-password"

      value = module.random_password.passwords["sql"]

      key_vault_id = module.key_vault.key_vault_ids["kv1"]

      content_type = "Password"

      expiration_date = "2027-12-31T23:59:59Z"
    }

  }

  depends_on = [

    module.random_password,

    module.key_vault, module.resource_group

  ]

}

# data "azurerm_key_vault_secret" "sql_password" {

#   name = "sql-password"

#   key_vault_id = module.key_vault.key_vault_ids["kv1"]

# }

module "sql_server" {

  source = "../../modules/sql_server"

  sql_servers = {

    sql1 = {

      name = "sohitsqlserver001"

      location = "Central India"

      resource_group_name = "mohit-rg"

      version = "12.0"

      admin_login = "sqladmin"

      admin_password = module.random_password.passwords["sql"]

      storage_endpoint = module.storage_account.primary_blob_endpoints["sa1"]

      storage_account_access_key = module.storage_account.primary_access_keys["sa1"]

    }

  }

  depends_on = [

    module.key_vault_secret, module.resource_group

  ]

}


module "sql_database" {

  source = "../../modules/sql_database"

  sql_databases = {

    db1 = {

      name = "sohitsqlserver001"

      server_id = module.sql_server.sql_server_ids["sql1"]

      sku_name = "Basic"

    }

  }

  depends_on = [

    module.sql_server, module.resource_group

  ]

}

module "route_table" {

  source = "../../modules/route_table"

  route_tables = var.route_tables

  depends_on = [

    module.subnet, module.resource_group, module.virtual_network

  ]

}

module "route" {

  source = "../../modules/route"

  routes = var.routes

  depends_on = [

    module.route_table, module.resource_group, module.virtual_network

  ]

}

module "subnet_route_association" {

  source = "../../modules/subnet_route_association"

  subnet_route_associations = {

    frontend = {

      subnet_id = module.subnet.subnet_ids["frontend_subnet"]

      route_table_id = module.route_table.route_table_ids["frontend_rt"]

    }

    backend = {

      subnet_id = module.subnet.subnet_ids["backend_subnet"]

      route_table_id = module.route_table.route_table_ids["backend_rt"]

    }

  }

  depends_on = [

    module.route_table,

    module.subnet, module.resource_group, module.virtual_network

  ]

}

module "private_dns_zone" {

  source = "../../modules/private_dns_zone"

  private_dns_zones = var.private_dns_zones

  depends_on = [ module.resource_group ]

}

module "private_dns_zone_link" {

  source = "../../modules/private_dns_zone_link"

  dns_links = {

    storage_link = {

      name = var.dns_links["storage_link"].name

      resource_group_name = var.dns_links["storage_link"].resource_group_name

      private_dns_zone_name = var.dns_links["storage_link"].private_dns_zone_name

      virtual_network_id = module.virtual_network.vnet_ids["vnet1"]

    }

    sql_link = {

      name = var.dns_links["sql_link"].name

      resource_group_name = var.dns_links["sql_link"].resource_group_name

      private_dns_zone_name = var.dns_links["sql_link"].private_dns_zone_name

      virtual_network_id = module.virtual_network.vnet_ids["vnet1"]

    }

  }

  depends_on = [

    module.private_dns_zone,

    module.virtual_network, module.resource_group

  ]

}

module "private_endpoint" {

  source = "../../modules/private_endpoint"

  private_endpoints = {

    storage_pe = {

      name = "storage-pe"

      location = "Central India"

      resource_group_name = "mohit-rg"

      subnet_id = module.subnet.subnet_ids["frontend_subnet"]

      private_connection_resource_id = module.storage_account.storage_account_ids["sa1"]

      subresource_names = [

        "blob"

      ]

    }

    sql_pe = {

      name = "sql-pe"

      location = "Central India"

      resource_group_name = "mohit-rg"

      subnet_id = module.subnet.subnet_ids["backend_subnet"]

      private_connection_resource_id = module.sql_server.sql_server_ids["sql1"]

      subresource_names = [

        "sqlServer"

      ]

    }

  }

  depends_on = [
  module.storage_account,
  module.sql_server,
  module.private_dns_zone,
  module.subnet,
  module.resource_group
]

}

module "load_balancer" {

  source = "../../modules/load_balancer"

  load_balancers = {

    lb1 = {

      name = var.load_balancers["lb1"].name

      location = var.load_balancers["lb1"].location

      resource_group_name = var.load_balancers["lb1"].resource_group_name

      sku = var.load_balancers["lb1"].sku

      frontend_ip_name = var.load_balancers["lb1"].frontend_ip_name

      public_ip_id = module.public_ip.public_ip_ids["lb_pip"]

    }

  }

  depends_on = [

    module.public_ip, module.resource_group

  ]

}

module "backend_pool" {

  source = "../../modules/backend_pool"

  backend_pools = {

    pool1 = {

      name = var.backend_pools["pool1"].name

      loadbalancer_id = module.load_balancer.lb_ids["lb1"]

    }

  }

  depends_on = [

    module.load_balancer, module.resource_group

  ]

}

module "backend_pool_nic_association" {

  source = "../../modules/backend_pool_nic_association"

  nic_associations = {

    vm1 = {

      nic_id = module.virtual_machine.nic_ids["linux_vm1"]

      ip_configuration_name = "internal"

      backend_pool_id = module.backend_pool.backend_pool_ids["pool1"]

    }

    vm2 = {

      nic_id = module.virtual_machine.nic_ids["linux_vm2"]

      ip_configuration_name = "internal"

      backend_pool_id = module.backend_pool.backend_pool_ids["pool1"]

    }

  }

  depends_on = [

    module.backend_pool,

    module.virtual_machine, module.resource_group, module.subnet, module.nsg, module.nsg_rule, module.subnet_nsg_association

  ]

}

module "health_probe" {

  source = "../../modules/health_probe"

  health_probes = {

    ssh_probe = {

      name = var.health_probes["ssh_probe"].name

      loadbalancer_id = module.load_balancer.lb_ids["lb1"]

      protocol = var.health_probes["ssh_probe"].protocol

      port = var.health_probes["ssh_probe"].port

    }

    http_probe = {

      name = var.health_probes["http_probe"].name

      loadbalancer_id = module.load_balancer.lb_ids["lb1"]

      protocol = var.health_probes["http_probe"].protocol

      port = var.health_probes["http_probe"].port

    }

  }

  depends_on = [

    module.load_balancer, module.resource_group, module.subnet, module.nsg, module.nsg_rule, module.subnet_nsg_association

  ]

}

module "lb_rule" {

  source = "../../modules/lb_rule"

  lb_rules = {

    http_rule = {

      name = var.lb_rules["http_rule"].name

      loadbalancer_id = module.load_balancer.lb_ids["lb1"]

      frontend_ip_configuration_name = module.load_balancer.frontend_ip_names["lb1"]

      backend_address_pool_ids = [
        module.backend_pool.backend_pool_ids["pool1"]
      ]

      probe_id = module.health_probe.probe_ids["http_probe"]

      protocol = var.lb_rules["http_rule"].protocol

      frontend_port = var.lb_rules["http_rule"].frontend_port

      backend_port = var.lb_rules["http_rule"].backend_port

    }

    ssh_rule = {

      name = var.lb_rules["ssh_rule"].name

      loadbalancer_id = module.load_balancer.lb_ids["lb1"]

      frontend_ip_configuration_name = module.load_balancer.frontend_ip_names["lb1"]

      backend_address_pool_ids = [
        module.backend_pool.backend_pool_ids["pool1"]
      ]

      probe_id = module.health_probe.probe_ids["ssh_probe"]

      protocol = var.lb_rules["ssh_rule"].protocol

      frontend_port = var.lb_rules["ssh_rule"].frontend_port

      backend_port = var.lb_rules["ssh_rule"].backend_port

    }

  }

  depends_on = [
    module.load_balancer,
    module.backend_pool,
    module.health_probe, module.resource_group, module.subnet, module.nsg, module.nsg_rule, module.subnet_nsg_association
  ]

}

module "outbound_rule" {

  source = "../../modules/outbound_rule"

  outbound_rules = {

    outbound1 = {

      name = var.outbound_rules["outbound1"].name

      loadbalancer_id = module.load_balancer.lb_ids["lb1"]

      protocol = var.outbound_rules["outbound1"].protocol

      backend_address_pool_id = module.backend_pool.backend_pool_ids["pool1"]

      frontend_ip_configuration_name = module.load_balancer.frontend_ip_names["lb1"]

    }

  }

  depends_on = [

    module.load_balancer,

    module.backend_pool, module.resource_group, module.subnet, module.nsg, module.nsg_rule, module.subnet_nsg_association

  ]

}

# module "application_gateway" {

#   source = "../../modules/application_gateway"

#   application_gateways = {

#     appgw1 = {

#       name = var.application_gateways["appgw1"].name

#       location = var.application_gateways["appgw1"].location

#       resource_group_name = var.application_gateways["appgw1"].resource_group_name

#       sku_name = var.application_gateways["appgw1"].sku_name

#       sku_tier = var.application_gateways["appgw1"].sku_tier

#       capacity = var.application_gateways["appgw1"].capacity

#       frontend_port = var.application_gateways["appgw1"].frontend_port

#       subnet_id = module.subnet.subnet_ids["appgw_subnet"]

#       public_ip_id = module.public_ip.public_ip_ids["appgw_pip"]

#       backend_addresses = [

#         "10.0.1.4",

#         "10.0.2.4"

#       ]

#     }

#   }

#   depends_on = [

#     module.subnet,

#     module.public_ip,

#     module.virtual_machine

#   ]

# }

