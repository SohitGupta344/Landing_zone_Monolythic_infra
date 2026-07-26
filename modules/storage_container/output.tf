output "container_ids" {

  value = {

    for k,v in azurerm_storage_container.container :

    k => v.id

  }

}