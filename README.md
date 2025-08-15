<!-- BEGIN_TF_DOCS -->
# Fortigate DHCP configuration module

This terraform module configures DHCP servers on a firewall

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_fortios"></a> [fortios](#provider\_fortios) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [fortios_systemdhcp6_server.dhcp](https://registry.terraform.io/providers/fortinetdev/fortios/latest/docs/resources/systemdhcp6_server) | resource |
| [fortios_systemdhcp_server.dhcp](https://registry.terraform.io/providers/fortinetdev/fortios/latest/docs/resources/systemdhcp_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_path"></a> [config\_path](#input\_config\_path) | Path to base configuration directory | `string` | n/a | yes |
| <a name="input_vdoms"></a> [vdoms](#input\_vdoms) | List of VDOMs from which to pull in configuration | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->