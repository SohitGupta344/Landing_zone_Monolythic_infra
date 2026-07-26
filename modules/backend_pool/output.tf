output "backend_pool_ids" {

  value = {

    for k,v in azurerm_lb_backend_address_pool.pool :

    k => v.id

  }

}