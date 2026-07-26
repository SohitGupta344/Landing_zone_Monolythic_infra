output "share_ids" {

  value = {

    for k,v in azurerm_storage_share.share :

    k => v.id

  }

}