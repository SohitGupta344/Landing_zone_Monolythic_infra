resource "azurerm_network_interface" "nic" {

  for_each = var.virtual_machines

  name                = each.value.nic_name

  location            = each.value.location

  resource_group_name = each.value.rg_name

  ip_configuration {

    name = "internal"

    subnet_id = each.value.subnet_id

    private_ip_address_allocation = "Dynamic"

  }

}

resource "azurerm_linux_virtual_machine" "linux" {

  for_each = var.virtual_machines

  name                = each.value.vm_name

  location            = each.value.location

  resource_group_name = each.value.rg_name

  size                = each.value.vm_size

  admin_username      = each.value.admin_username

  # admin_password      = each.value.admin_password

  disable_password_authentication = true

  admin_ssh_key {

  username   = each.value.admin_username

  public_key = file(each.value.public_key_path)

}

  network_interface_ids = [

    azurerm_network_interface.nic[each.key].id

  ]

  os_disk {

    caching              = "ReadWrite"

    storage_account_type = "Standard_LRS"

  }

  source_image_reference {

    publisher = "Canonical"

    offer     = "0001-com-ubuntu-server-jammy"

    sku       = "22_04-lts"

    version   = "latest"

  }

}