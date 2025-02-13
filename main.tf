terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.43.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  # Authentication using Service Principal
  client_id       = var.azure_client_id       # Variable for Client ID
  client_secret   = var.azure_client_secret   # Variable for Client Secret
  tenant_id       = var.azure_tenant_id       # Variable for Tenant ID
  subscription_id = var.azure_subscription_id # Variable for Subscription ID
}

resource "random_string" "uniquestring" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "811-6f832168-provide-continuous-delivery-with-gith"
  location = "westus"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.uniquestring.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
