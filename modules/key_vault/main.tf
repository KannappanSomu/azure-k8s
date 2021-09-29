/*
* # Azure Key Vault.
*
* This module creates a Key Vault and assigns Access Policy for service principal used by Terraform to manage resources.
*/

data azurerm_client_config current {}

resource azurerm_key_vault key_vault {
  name                = var.vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = var.sku_name
  soft_delete_retention_days = "7"
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled = var.purge_protection_enabled

  network_acls {
    default_action = var.network_acls_default_action
    bypass         = var.network_acls_bypass
  }

}

# Grant access for Terraform modules
resource "azurerm_key_vault_access_policy" "default" {
  depends_on = [azurerm_key_vault.key_vault]

  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  storage_permissions     = var.storage_permissions
  certificate_permissions = var.certificate_permissions
}