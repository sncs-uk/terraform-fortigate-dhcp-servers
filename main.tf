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
resource "fortios_systemdhcp_server" "dhcp" {
  for_each = { for server in var.dhcp4 : server.interface => server }

  fosid                          = each.value.fosid
  status                         = each.value.status
  lease_time                     = each.value.lease_time
  mac_acl_default_action         = each.value.mac_acl_default_action
  forticlient_on_net_status      = each.value.forticlient_on_net_status
  dns_service                    = each.value.dns_service
  dns_server1                    = each.value.dns_server1
  dns_server2                    = each.value.dns_server2
  dns_server3                    = each.value.dns_server3
  dns_server4                    = each.value.dns_server4
  wifi_ac_service                = each.value.wifi_ac_service
  wifi_ac1                       = each.value.wifi_ac1
  wifi_ac2                       = each.value.wifi_ac2
  wifi_ac3                       = each.value.wifi_ac3
  ntp_service                    = each.value.ntp_service
  ntp_server1                    = each.value.ntp_server1
  ntp_server2                    = each.value.ntp_server2
  ntp_server3                    = each.value.ntp_server3
  domain                         = each.value.domain
  wins_server1                   = each.value.wins_server1
  wins_server2                   = each.value.wins_server2
  default_gateway                = each.value.default_gateway
  next_server                    = each.value.next_server
  netmask                        = each.value.netmask
  interface                      = each.value.interface
  timezone_option                = each.value.timezone_option
  timezone                       = each.value.timezone
  filename                       = each.value.filename
  template                       = each.value.template
  template_subnet                = each.value.template_subnet
  template_subnet_from_interface = each.value.template_subnet_from_interface
  server_type                    = each.value.server_type
  ip_mode                        = each.value.ip_mode
  conflicted_ip_timeout          = each.value.conflicted_ip_timeout
  ipsec_lease_hold               = each.value.ipsec_lease_hold
  auto_configuration             = each.value.auto_configuration
  dhcp_settings_from_fortiipam   = each.value.dhcp_settings_from_fortiipam
  auto_managed_status            = each.value.auto_managed_status
  ddns_update                    = each.value.ddns_update
  ddns_update_override           = each.value.ddns_update_override
  ddns_server_ip                 = each.value.ddns_server_ip
  ddns_zone                      = each.value.ddns_zone
  ddns_auth                      = each.value.ddns_auth
  ddns_keyname                   = each.value.ddns_keyname
  ddns_key                       = each.value.ddns_key
  ddns_ttl                       = each.value.ddns_ttl
  vci_match                      = each.value.vci_match
  shared_subnet                  = each.value.shared_subnet
  relay_agent                    = each.value.relay_agent
  vdomparam                      = each.value.vdomparam

  dynamic "ip_range" {
    for_each = { for range in each.value.ip_range : range.start_ip => range }
    content {
      id         = index(each.value.ranges, ip_range.value) + 1
      start_ip   = ip_range.value.start_ip
      end_ip     = ip_range.value.end_ip
      vci_match  = ip_range.value.vci_match
      uci_match  = ip_range.value.uci_match
      oui_match  = ip_range.value.oui_match
      lease_time = ip_range.value.lease_time
      vendor     = ip_range.value.vendor

      dynamic "vci_string" {
        for_each = { for str in ip_range.value.vci_string : str => str }
        content {
          vci_string = vci_string.value
        }
      }
      dynamic "uci_string" {
        for_each = { for str in ip_range.value.uci_string : str => str }
        content {
          uci_string = uci_string.value
        }
      }
      dynamic "oui_string" {
        for_each = { for str in ip_range.value.oui_string : str => str }
        content {
          oui_string = oui_string.value
        }
      }
    }
  }

  dynamic "tftp_server" {
    for_each = { for server in each.value.tftp_server : server => server }
    content {
      tftp_server = tftp_server.value
    }
  }

  dynamic "options" {
    for_each = { for option in each.value.options : index(try(each.value.options, []), option) => option }
    content {
      id    = options.value.id
      code  = options.value.code
      type  = options.value.type
      value = options.value.value
      ip    = options.value.ip

      vci_match = options.value.vci_match
      uci_match = options.value.uci_match

      dynamic "vci_string" {
        for_each = { for str in options.value.vci_string : str => str }
        content {
          vci_string = vci_string.value
        }
      }
      dynamic "uci_string" {
        for_each = { for str in options.value.uci_string : str => str }
        content {
          uci_string = uci_string.value
        }
      }
    }
  }
  dynamic "vci_string" {
    for_each = { for str in each.value.vci_string : str => str }
    content {
      vci_string = vci_string.value
    }
  }

  dynamic "exclude_range" {
    for_each = { for exclude_range in each.value.exclude_range : index(each.value.exclude_range, exclude_range) => exclude_range }
    content {
      id         = index(each.value.ranges, exclude_range.value) + 1
      start_ip   = exclude_range.value.start
      end_ip     = exclude_range.value.end
      vci_match  = exclude_range.value.vci_match
      uci_match  = exclude_range.value.uci_match
      oui_match  = exclude_range.value.oui_match
      lease_time = exclude_range.value.lease_time
      vendor     = exclude_range.value.vendor

      dynamic "vci_string" {
        for_each = { for str in exclude_range.value.vci_string : str => str }
        content {
          vci_string = vci_string.value
        }
      }
      dynamic "uci_string" {
        for_each = { for str in exclude_range.value.uci_string : str => str }
        content {
          uci_string = uci_string.value
        }
      }
      dynamic "oui_string" {
        for_each = { for str in exclude_range.value.oui_string : str => str }
        content {
          oui_string = oui_string.value
        }
      }
    }
  }

  dynamic "reserved_address" {
    for_each = { for reserved_address in each.value.reserved_address : reserved_address.mac => reserved_address }
    content {
      id              = reserved_address.value.id
      type            = reserved_address.value.type
      ip              = reserved_address.value.ip
      mac             = reserved_address.value.mac
      action          = reserved_address.value.action
      circuit_id_type = reserved_address.value.circuit_id_type
      circuit_id      = reserved_address.value.circuit_id
      remote_id_type  = reserved_address.value.remote_id_type
      remote_id       = reserved_address.value.remote_id
      description     = reserved_address.value.description
    }
  }
}

resource "fortios_systemdhcp6_server" "dhcp" {
  for_each               = { for server in var.dhcp6 : server.interface => server }
  fosid                  = each.value.fosid
  status                 = each.value.status
  rapid_commit           = each.value.rapid_commit
  lease_time             = each.value.lease_time
  dns_service            = each.value.dns_service
  dns_search_list        = each.value.dns_search_list
  dns_server1            = each.value.dns_server1
  dns_server2            = each.value.dns_server2
  dns_server3            = each.value.dns_server3
  dns_server4            = each.value.dns_server4
  domain                 = each.value.domain
  subnet                 = each.value.subnet
  interface              = each.value.interface
  delegated_prefix_route = each.value.delegated_prefix_route
  option1                = each.value.option1
  option2                = each.value.option2
  option3                = each.value.option3
  upstream_interface     = each.value.upstream_interface
  delegated_prefix_iaid  = each.value.delegated_prefix_iaid
  ip_mode                = each.value.ip_mode
  prefix_mode            = each.value.prefix_mode
  vdomparam              = each.value.vdomparam
  update_if_exist        = each.value.update_if_exist

  dynamic "options" {
    for_each = { for option in each.value.options : index(each.value.options, option) => option }
    content {
      id    = options.value.id
      code  = options.value.code
      type  = options.value.type
      value = options.value.value
      ip6   = options.value.ip6

      vci_match = options.value.vci_match

      dynamic "vci_string" {
        for_each = { for str in options.value.vci_string : str => str }
        content {
          vci_string = vci_string.value
        }
      }
    }
  }

  dynamic "prefix_range" {
    for_each = { for range in each.value.prefix_range : index(each.value.prefix_range, range) => range }
    content {
      id            = prefix_range.value.id
      start_prefix  = prefix_range.value.start_prefix
      end_prefix    = prefix_range.value.end_prefix
      prefix_length = prefix_range.value.prefix_length
    }
  }

  dynamic "ip_range" {
    for_each = { for range in each.value.ip_range : range.start => range }
    content {
      id        = index(each.value.ranges, ip_range.value) + 1
      start_ip  = ip_range.value.start_ip
      end_ip    = ip_range.value.end_ip
      vci_match = ip_range.value.vci_match

      dynamic "vci_string" {
        for_each = { for str in ip_range.value.vci_string : str => str }
        content {
          vci_string = vci_string.value
        }
      }
    }
  }
}
