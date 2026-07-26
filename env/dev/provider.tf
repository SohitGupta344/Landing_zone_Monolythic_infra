terraform {

  required_version = ">= 1.10.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    version = "~>4.38"
    }
  }

  backend "azurerm" {
    resource_group_name  = "sohit-rg"
    storage_account_name = "sohittfstate001"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }

}

provider "azurerm" {
  subscription_id = "ff8dbcde-c654-4f43-be29-1fa4ab0bad46"
  features {}
}