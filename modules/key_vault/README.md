# Azure Key Vault.

This module creates a Key Vault and assigns Access Policy for service principal used by Terraform to manage resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | >= 2.47.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.47.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/2.47.0/docs/data-sources/client_config) |
| [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/2.47.0/docs/resources/key_vault) |
| [azurerm_key_vault_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.47.0/docs/resources/key_vault_access_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vault\_name | Specifies the name of the Key Vault.<br>Name generated as [vault\_name]-[environment]-[uniq\_id].<br>Changing this forces a new resource to be created. | `string` | `"key-vault"` | no |
| sku\_name | The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | `"standard"` | no |
| enabled\_for\_disk\_encryption | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| enabled\_for\_deployment | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| enabled\_for\_template\_deployment | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| soft\_delete\_enabled | Should Soft Delete be enabled for this Key Vault?<br>Note: Once Soft Delete has been Enabled it's not possible to Disable it. | `bool` | `true` | no |
| purge\_protection\_enabled | Is Purge Protection enabled for this Key Vault?<br>Note: Once Purge Protection has been Enabled it's not possible to Disable it. Support for disabling purge protection is being tracked in this Azure API issue. Deleting the Key Vault with Purge Protection Enabled will schedule the Key Vault to be deleted (which will happen by Azure in the configured number of days, currently 90 days - which will be configurable in Terraform in the future). | `bool` | `false` | no |
| network\_acls\_default\_action | The Default Action to use when no rules match from ip\_rules / virtual\_network\_subnet\_ids. Possible values are Allow and Deny. | `string` | `"Allow"` | no |
| network\_acls\_bypass | Specifies which traffic can bypass the network rules. Possible values are AzureServices and None. | `string` | `"AzureServices"` | no |
| key\_permissions | List of key permissions, must be one or more from the following:<br> backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey. | `list` | <pre>[<br>  "get",<br>  "create",<br>  "delete",<br>  "list"<br>]</pre> | no |
| secret\_permissions | List of secret permissions, must be one or more from the following:<br> backup, delete, get, list, purge, recover, restore and set. | `list` | <pre>[<br>  "set",<br>  "get",<br>  "delete",<br>  "list",<br>  "purge",<br>  "recover"<br>]</pre> | no |
| storage\_permissions | List of storage permissions, must be one or more from the following:<br> backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update. | `list` | <pre>[<br>  "get",<br>  "delete",<br>  "purge",<br>  "recover"<br>]</pre> | no |
| certificate\_permissions | List of certificate permissions, must be one or more from the following:<br> backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update. | `list` | <pre>[<br>  "get",<br>  "delete",<br>  "list",<br>  "purge",<br>  "recover"<br>]</pre> | no |
| primary | Global configuration for module. Please read main documentation. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| key\_vault\_id | The ID of the Key Vault. |
