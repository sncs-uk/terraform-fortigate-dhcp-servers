/**
 * # Fortigate DHCP configuration module
 *
 * This terraform module configures DHCP servers on a firewall
 */
terraform {
  required_version = ">= 1.13.0"
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = ">= 1.22.0"
    }
  }
}

locals {
  dhcp_yaml = yamldecode(file("${var.config_path}/dhcp-servers.yaml"))
  dhcp      = try(local.dhcp_yaml.dhcp, [])
  dhcp6     = try(local.dhcp_yaml.dhcp6, [])
}
locals {
}

resource "fortios_systemdhcp_server" "dhcp" {
  for_each = { for server in local.dhcp : server.interface => server }

  interface              = each.value.interface
  netmask                = each.value.netmask
  default_gateway        = each.value.gateway
  lease_time             = each.value.lease_time
  mac_acl_default_action = try(each.value.mac_acl_default_action, null)

  vdomparam = each.value.vdom

  dns_server1 = try(each.value.dns[0], null)
  dns_server2 = try(each.value.dns[1], null)
  dns_server3 = try(each.value.dns[2], null)
  dns_server4 = try(each.value.dns[3], null)

  ntp_server1 = try(each.value.ntp[0], null)
  ntp_server2 = try(each.value.ntp[1], null)
  ntp_server3 = try(each.value.ntp[2], null)

  dynamic "ip_range" {
    for_each = { for range in each.value.ranges : range.start => range }
    content {
      id       = index(each.value.ranges, ip_range.value) + 1
      start_ip = ip_range.value.start
      end_ip   = ip_range.value.end
    }
  }

  dynamic "reserved_address" {
    for_each = { for reservation in try(each.value.reservations, []) : reservation.mac => reservation }
    content {
      id          = index(each.value.reservations, reserved_address.value) + 1
      type        = "mac"
      mac         = reserved_address.value.mac
      ip          = reserved_address.value.ip
      action      = "reserved"
      description = reserved_address.value.description
    }
  }
  dynamic_sort_subtable = "natural"
}

resource "fortios_systemdhcp6_server" "dhcp" {
  for_each = { for server in local.dhcp6 : server.interface => server }

  fosid      = index(local.dhcp6, each.value) + 1
  interface  = each.value.interface
  subnet     = each.value.subnet
  lease_time = each.value.lease_time

  ip_mode               = try(each.value.ip_mode, null)
  delegated_prefix_iaid = try(each.value.delegated_prefix_iaid, null)
  upstream_interface    = try(each.value.upstream_interface, null)

  vdomparam = each.value.vdom

  dns_server1           = try(each.value.dns[0], null)
  dns_server2           = try(each.value.dns[1], null)
  dns_server3           = try(each.value.dns[2], null)
  dns_server4           = try(each.value.dns[3], null)
  dynamic_sort_subtable = "natural"
}
