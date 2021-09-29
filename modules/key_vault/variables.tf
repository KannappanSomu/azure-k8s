###############################################################################
# Azure Key Vault default configuration.
variable vault_name {
  description = "Specifies the name of the Key Vault.\nName generated as [vault_name]-[environment]-[uniq_id].\nChanging this forces a new resource to be created."
  default     = "key-vault-234"
}
variable sku_name {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  default     = "standard"
}

variable enabled_for_disk_encryption {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = false
}
variable enabled_for_deployment {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  default     = false
}
variable enabled_for_template_deployment {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default     = false
}

variable soft_delete_enabled {
  description = "Should Soft Delete be enabled for this Key Vault?\nNote: Once Soft Delete has been Enabled it's not possible to Disable it."
  default     = true
}
variable purge_protection_enabled {
  description = "Is Purge Protection enabled for this Key Vault?\nNote: Once Purge Protection has been Enabled it's not possible to Disable it. Support for disabling purge protection is being tracked in this Azure API issue. Deleting the Key Vault with Purge Protection Enabled will schedule the Key Vault to be deleted (which will happen by Azure in the configured number of days, currently 90 days - which will be configurable in Terraform in the future)."
  default     = false
}

variable network_acls_default_action {
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
  default     = "Allow"
}

variable network_acls_bypass {
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None."
  default     = "AzureServices"
}
###############################################################################
# Azure Key Vault Policy default configuration.
variable key_permissions {
  description = "List of key permissions, must be one or more from the following:\n backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default = [
    "get",
    "create",
    "delete",
    "list",
  ]
}
variable secret_permissions {
  description = "List of secret permissions, must be one or more from the following:\n backup, delete, get, list, purge, recover, restore and set."
  default = [
    "set",
    "get",
    "delete",
    "list",
    "purge",
    "recover",
  ]
}
variable storage_permissions {
  description = "List of storage permissions, must be one or more from the following:\n backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update."
  default = [
    "get",
    "delete",
    "purge",
    "recover",
  ]
}
variable certificate_permissions {
  description = "List of certificate permissions, must be one or more from the following:\n backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update."
  default = [
    "get",
    "delete",
    "list",
    "purge",
    "recover",
  ]
}
###############################################################################
# variable module_depends {
#   description = "Module dependency."
#   type        = any
#   default     = null
# }
variable resource_group_name {
  description = "Global configuration for module. Please read main documentation."
  type        = any
}
variable location {
  description = "Global configuration for module. Please read main documentation."
  type        = any
}
###############################################################################