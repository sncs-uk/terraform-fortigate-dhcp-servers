/**
 * # Fortigate DHCP configuration module
 *
 * This terraform module configures DHCP servers on a firewall
 */
terraform {
  required_version = ">= 1.11.0"
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

  fosid                        = try(each.value.fosid, null)
  status                       = try(each.value.status, null)
  lease_time                   = try(each.value.lease_time, null)
  mac_acl_default_action       = try(each.value.mac_acl_default_action, null)
  forticlient_on_net_status    = try(each.value.forticlient_on_net_status, null)
  dns_service                  = try(each.value.dns_service, null)
  dns_server1                  = try(each.value.dns[0], null)
  dns_server2                  = try(each.value.dns[1], null)
  dns_server3                  = try(each.value.dns[2], null)
  dns_server4                  = try(each.value.dns[3], null)
  wifi_ac_service              = try(each.value.wifi_ac_service, null)
  wifi_ac1                     = try(each.value.wifi_ac1, null)
  wifi_ac2                     = try(each.value.wifi_ac2, null)
  wifi_ac3                     = try(each.value.wifi_ac3, null)
  ntp_service                  = try(each.value.ntp_service, null)
  ntp_server1                  = try(each.value.ntp[0], null)
  ntp_server2                  = try(each.value.ntp[1], null)
  ntp_server3                  = try(each.value.ntp[2], null)
  domain                       = try(each.value.domain, null)
  wins_server1                 = try(each.value.wins_server1, null)
  wins_server2                 = try(each.value.wins_server2, null)
  default_gateway              = try(each.value.default_gateway, null)
  next_server                  = try(each.value.next_server, null)
  netmask                      = try(each.value.netmask, null)
  interface                    = try(each.value.interface, null)
  timezone_option              = try(each.value.timezone_option, null)
  timezone                     = try(each.value.timezone, null)
  filename                     = try(each.value.filename, null)
  server_type                  = try(each.value.server_type, null)
  ip_mode                      = try(each.value.ip_mode, null)
  conflicted_ip_timeout        = try(each.value.conflicted_ip_timeout, null)
  ipsec_lease_hold             = try(each.value.ipsec_lease_hold, null)
  auto_configuration           = try(each.value.auto_configuration, null)
  dhcp_settings_from_fortiipam = try(each.value.dhcp_settings_from_fortiipam, null)
  auto_managed_status          = try(each.value.auto_managed_status, null)
  ddns_update                  = try(each.value.ddns_update, null)
  ddns_update_override         = try(each.value.ddns_update_override, null)
  ddns_server_ip               = try(each.value.ddns_server_ip, null)
  ddns_zone                    = try(each.value.ddns_zone, null)
  ddns_auth                    = try(each.value.ddns_auth, null)
  ddns_keyname                 = try(each.value.ddns_keyname, null)
  ddns_key                     = try(each.value.ddns_key, null)
  ddns_ttl                     = try(each.value.ddns_ttl, null)
  vci_match                    = try(each.value.vci_match, null)
  shared_subnet                = try(each.value.shared_subnet, null)
  relay_agent                  = try(each.value.relay_agent, null)
  vdomparam                    = try(each.value.vdom, null)

  dynamic "ip_range" {
    for_each = { for range in each.value.ranges : range.start => range }
    content {
      id         = index(each.value.ranges, ip_range.value) + 1
      start_ip   = ip_range.value.start
      end_ip     = ip_range.value.end
      vci_match  = try(ip_range.value.vci_match, null)
      uci_match  = try(ip_range.value.uci_match, null)
      lease_time = try(ip_range.value.lease_time, null)

      dynamic "vci_string" {
        for_each = { for str in try(ip_range.value.vci_string, []) : str => str }
        content {
          vci_string = vci_string.value
        }
      }
      dynamic "uci_string" {
        for_each = { for str in try(ip_range.value.uci_string, []) : str => str }
        content {
          uci_string = uci_string.value
        }
      }
    }
  }

  dynamic "tftp_server" {
    for_each = { for tftp_server in try(each.value.tftp_server, []) : tftp_server => tftp_server }
    content {
      tftp_server = tftp_server.value
    }
  }

  dynamic "options" {
    for_each = { for option in try(each.value.options, []) : option.code => option }
    content {
      id        = index(each.value.options, options.value) + 1
      code      = try(options.value.code, null)
      type      = try(options.value.type, null)
      value     = try(options.value.value, null)
      ip        = try(options.value.ip, null)
      vci_match = try(options.value.vci_match, null)
      uci_match = try(options.value.uci_match, null)

      dynamic "vci_string" {
        for_each = { for str in try(options.value.vci_string, []) : str => str }
        content {
          vci_string = vci_string.value
        }
      }
      dynamic "uci_string" {
        for_each = { for str in try(options.value.uci_string, []) : str => str }
        content {
          uci_string = uci_string.value
        }
      }
    }
  }

  dynamic "vci_string" {
    for_each = { for str in try(each.value.vci_string, []) : str => str }
    content {
      vci_string = vci_string.value
    }
  }

  dynamic "exclude_range" {
    for_each = { for exclude_range in try(each.value.exclude_ranges, []) : index(try(each.value.exclude_ranges, []), exclude_range) => exclude_range }
    content {
      id         = index(each.value.exclude_ranges, exclude_range.value) + 1
      start_ip   = try(exclude_range.value.start_ip, null)
      end_ip     = try(exclude_range.value.end_ip, null)
      vci_match  = try(exclude_range.value.vci_match, null)
      uci_match  = try(exclude_range.value.uci_match, null)
      lease_time = try(exclude_range.value.lease_time, null)

      dynamic "vci_string" {
        for_each = { for str in try(exclude_range.value.vci_string, []) : str => str }
        content {
          vci_string = vci_string.value
        }
      }
      dynamic "uci_string" {
        for_each = { for str in try(exclude_range.value.uci_string, []) : str => str }
        content {
          uci_string = uci_string.value
        }
      }
    }
  }

  dynamic "reserved_address" {
    for_each = { for reservation in try(each.value.reservations, []) : index(try(each.value.reservations, []), reservation) => reservation }
    content {
      id              = index(each.value.reservations, reserved_address.value) + 1
      type            = try(reserved_address.value.type, "mac")
      ip              = try(reserved_address.value.ip, null)
      mac             = try(reserved_address.value.mac, null)
      action          = try(reserved_address.value.action, "reserved")
      circuit_id_type = try(reserved_address.value.circuit_id_type, null)
      circuit_id      = try(reserved_address.value.circuit_id, null)
      remote_id_type  = try(reserved_address.value.remote_id_type, null)
      remote_id       = try(reserved_address.value.remote_id, null)
      description     = try(reserved_address.value.description, null)
    }
  }
  dynamic_sort_subtable = "natural"
}

resource "fortios_systemdhcp6_server" "dhcp" {
  for_each = { for server in local.dhcp6 : server.interface => server }

  fosid                  = try(each.value.fosid, null)
  status                 = try(each.value.status, null)
  rapid_commit           = try(each.value.rapid_commit, null)
  lease_time             = try(each.value.lease_time, null)
  dns_service            = try(each.value.dns_service, null)
  dns_search_list        = try(each.value.dns_search_list, null)
  dns_server1            = try(each.value.dns[0], null)
  dns_server2            = try(each.value.dns[1], null)
  dns_server3            = try(each.value.dns[2], null)
  dns_server4            = try(each.value.dns[3], null)
  domain                 = try(each.value.domain, null)
  subnet                 = try(each.value.subnet, null)
  interface              = try(each.value.interface, null)
  delegated_prefix_route = try(each.value.delegated_prefix_route, null)
  option1                = try(each.value.option1, null)
  option2                = try(each.value.option2, null)
  option3                = try(each.value.option3, null)
  upstream_interface     = try(each.value.upstream_interface, null)
  delegated_prefix_iaid  = try(each.value.delegated_prefix_iaid, null)
  ip_mode                = try(each.value.ip_mode, null)
  prefix_mode            = try(each.value.prefix_mode, null)

  vdomparam = each.value.vdom

  dynamic "options" {
    for_each = { for option in try(each.value.options, []) : option.code => option }
    content {
      id        = index(each.value.options, options.value) + 1
      code      = try(options.value.code, null)
      type      = try(options.value.type, null)
      value     = try(options.value.value, null)
      ip6       = try(options.value.ip6, null)
      vci_match = try(options.value.vci_match, null)

      dynamic "vci_string" {
        for_each = { for str in try(options.value.vci_string, []) : str => str }
        content {
          vci_string = vci_string.value
        }
      }
    }
  }

  dynamic "prefix_range" {
    for_each = { for prefix_range in try(each.value.prefix_ranges, []) : index(try(each.value.prefix_ranges, []), prefix_range) => prefix_range }
    content {
      id            = try(prefix_range.value.id, null)
      start_prefix  = try(prefix_range.value.start_prefix, null)
      end_prefix    = try(prefix_range.value.end_prefix, null)
      prefix_length = try(prefix_range.value.prefix_length, null)
    }
  }

  dynamic "ip_range" {
    for_each = { for range in each.value.ranges : range.start => range }
    content {
      id        = index(each.value.ranges, ip_range.value) + 1
      start_ip  = ip_range.value.start
      end_ip    = ip_range.value.end
      vci_match = try(ip_range.value.vci_match, null)

      dynamic "vci_string" {
        for_each = { for str in try(ip_range.value.vci_string, []) : str => str }
        content {
          vci_string = vci_string.value
        }
      }
    }
  }
  dynamic_sort_subtable = "natural"
}
