output "vm_ids" {

  value = {

    for k,v in azurerm_linux_virtual_machine.linux :

    k => v.id

  }

}

output "nic_ids" {

  value = {

    for k,v in azurerm_network_interface.nic :

    k => v.id

  }

}