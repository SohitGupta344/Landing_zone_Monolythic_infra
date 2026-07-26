resource "random_password" "password" {

  for_each = var.passwords

  length = each.value.length

  special = true

}