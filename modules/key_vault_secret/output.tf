output "secret_ids" {

  value = {

    for k,v in azurerm_key_vault_secret.secret :

    k => v.id

  }

}