variable "dhcp4" {
  type = list(object({
    fosid                     = optional(number)
    status                    = optional(string)
    lease_time                = optional(number)
    mac_acl_default_action    = optional(string)
    forticlient_on_net_status = optional(string)
    dns_service               = optional(string)
    dns_server1               = optional(string)
    dns_server2               = optional(string)
    dns_server3               = optional(string)
    dns_server4               = optional(string)
    wifi_ac_service           = optional(string)
    wifi_ac1                  = optional(string)
    wifi_ac2                  = optional(string)
    wifi_ac3                  = optional(string)
    ntp_service               = optional(string)
    ntp_server1               = optional(string)
    ntp_server2               = optional(string)
    ntp_server3               = optional(string)
    domain                    = optional(string)
    wins_server1              = optional(string)
    wins_server2              = optional(string)
    default_gateway           = optional(string)
    next_server               = optional(string)
    netmask                   = string
    interface                 = string
    ip_range = optional(list(object({
      id         = optional(number)
      start_ip   = string
      end_ip     = string
      vci_match  = optional(string)
      vci_string = optional(list(string), [])
      uci_match  = optional(string)
      uci_string = optional(list(string), [])
      oui_match  = optional(string)
      oui_string = optional(list(string), [])
      lease_time = optional(number)
      vendor     = optional(string)
    })), [])
    timezone_option                = optional(string)
    timezone                       = optional(string)
    tftp_server                    = optional(list(string), [])
    filename                       = optional(string)
    template                       = optional(string)
    template_subnet                = optional(string)
    template_subnet_from_interface = optional(string)
    options = optional(list(object({
      id         = optional(number)
      code       = number
      type       = optional(string)
      value      = optional(string)
      ip         = optional(string)
      vci_match  = optional(string)
      vci_string = optional(list(string), [])
      uci_match  = optional(string)
      uci_string = optional(list(string), [])
    })), [])
    server_type                  = optional(string)
    ip_mode                      = optional(string)
    conflicted_ip_timeout        = optional(number)
    ipsec_lease_hold             = optional(number)
    auto_configuration           = optional(string)
    dhcp_settings_from_fortiipam = optional(string)
    auto_managed_status          = optional(string)
    ddns_update                  = optional(string)
    ddns_update_override         = optional(string)
    ddns_server_ip               = optional(string)
    ddns_zone                    = optional(string)
    ddns_auth                    = optional(string)
    ddns_keyname                 = optional(string)
    ddns_key                     = optional(string)
    ddns_ttl                     = optional(string)
    vci_match                    = optional(string)
    vci_string                   = optional(list(string), [])
    exclude_range = optional(list(object({
      id         = optional(number)
      start_ip   = string
      end_ip     = string
      vci_match  = optional(string)
      vci_string = optional(list(string), [])
      uci_match  = optional(string)
      uci_string = optional(list(string), [])
      oui_match  = optional(string)
      oui_string = optional(list(string), [])
      lease_time = optional(number)
      vendor     = optional(string)
    })), [])
    shared_subnet = optional(string)
    relay_agent   = optional(string)
    reserved_address = optional(list(object({
      id              = optional(number)
      type            = optional(string)
      ip              = string
      mac             = string
      action          = optional(string)
      circuit_id_type = optional(string)
      circuit_id      = optional(string)
      remote_id_type  = optional(string)
      remote_id       = optional(string)
      description     = optional(string)
    })), [])
    dynamic_sort_subtable = optional(string, "natural")
    get_all_tables        = optional(bool, false)
    vdomparam             = optional(string)
    update_if_exists      = optional(bool)
  }))
  description = "DHCPv4 servers to create"
  default     = []

  validation {
    condition     = alltrue([for o in var.dhcp4 : o.status == null || contains(["enable", "disable"], o.status)])
    error_message = "Parameter `status` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.mac_acl_default_action == null || contains(["assign", "block"], o.mac_acl_default_action)])
    error_message = "Parameter `rapid_commit` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.forticlient_on_net_status == null || contains(["enable", "disable"], o.forticlient_on_net_status)])
    error_message = "Parameter `forticlient_on_net_status` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.dns_service == null || contains(["delegated", "default", "specify"], o.dns_service)])
    error_message = "Parameter `dns_service` must be one of `delegated`, `default`, or `specify`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.wifi_ac_service == null || contains(["specify", "local"], o.wifi_ac_service)])
    error_message = "Parameter `wifi_ac_service` must be one of `specify`, or `local`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.ntp_service == null || contains(["local", "default", "specify"], o.ntp_service)])
    error_message = "Parameter `ntp_service` must be one of `local`, `default`, or `specify`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.timezone_option == null || contains(["disable", "default", "specify"], o.timezone_option)])
    error_message = "Parameter `timezone_option` must be one of `disable`, `default`, or `specify`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.template_subnet_from_interface == null || contains(["enable", "disable"], o.template_subnet_from_interface)])
    error_message = "Parameter `template_subnet_from_interface` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.server_type == null || contains(["regular", "ipsec"], o.server_type)])
    error_message = "Parameter `server_type` must be one of `regular`, or `ipsec`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.ip_mode == null || contains(["range", "usrgrp"], o.ip_mode)])
    error_message = "Parameter `ip_mode` must be one of `range`, or `usrgrp`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.auto_configuration == null || contains(["enable", "disable"], o.auto_configuration)])
    error_message = "Parameter `auto_configuration` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.dhcp_settings_from_fortiipam == null || contains(["enable", "disable"], o.dhcp_settings_from_fortiipam)])
    error_message = "Parameter `dhcp_settings_from_fortiipam` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.auto_managed_status == null || contains(["enable", "disable"], o.auto_managed_status)])
    error_message = "Parameter `auto_managed_status` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.ddns_update == null || contains(["enable", "disable"], o.ddns_update)])
    error_message = "Parameter `ddns_update` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.ddns_update_override == null || contains(["enable", "disable"], o.ddns_update_override)])
    error_message = "Parameter `ddns_update_override` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.ddns_auth == null || contains(["disable", "tsig"], o.ddns_auth)])
    error_message = "Parameter `ddns_auth` must be one of `disable`, or `tsig`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.vci_match == null || contains(["enable", "disable"], o.vci_match)])
    error_message = "Parameter `vci_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp4 : o.shared_subnet == null || contains(["enable", "disable"], o.shared_subnet)])
    error_message = "Parameter `shared_subnet` must be one of `enable`, or `disable`"
  }

  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.ip_range : p.vci_match == null || contains(["enable", "disable"], p.vci_match)]]))
    error_message = "Parameter `ip_range.vci_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.ip_range : p.uci_match == null || contains(["enable", "disable"], p.uci_match)]]))
    error_message = "Parameter `ip_range.uci_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.ip_range : p.oui_match == null || contains(["enable", "disable"], p.oui_match)]]))
    error_message = "Parameter `ip_range.oui_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.ip_range : p.lease_time == null || p.lease_time >= 0]]))
    error_message = "Parameter `ip_range.lease_time` must be zero or greater"
  }

  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.options : p.type == null || contains(["hex", "string", "ip", "fqdn"], p.type)]]))
    error_message = "Parameter `options.type` must be one of `hex`, `string`, `ip`, or `fqdn`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.options : p.vci_match == null || contains(["enable", "disable"], p.vci_match)]]))
    error_message = "Parameter `options.vci_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.options : p.uci_match == null || contains(["enable", "disable"], p.uci_match)]]))
    error_message = "Parameter `options.uci_match` must be one of `enable`, or `disable`"
  }

  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.exclude_range : p.vci_match == null || contains(["enable", "disable"], p.vci_match)]]))
    error_message = "Parameter `exclude_range.vci_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.exclude_range : p.uci_match == null || contains(["enable", "disable"], p.uci_match)]]))
    error_message = "Parameter `exclude_range.uci_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.exclude_range : p.oui_match == null || contains(["enable", "disable"], p.oui_match)]]))
    error_message = "Parameter `exclude_range.oui_match` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.exclude_range : p.lease_time == null || p.lease_time >= 0]]))
    error_message = "Parameter `exclude_range.lease_time` must be zero or greater"
  }

  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.reserved_address : p.type == null || contains(["mac", "option82"], p.type)]]))
    error_message = "Parameter `reserved_address.type` must be one of `mac`, or `option82`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.reserved_address : p.action == null || contains(["assign", "block", "reserved"], p.action)]]))
    error_message = "Parameter `reserved_address.action` must be one of `assign`, `block`, or `reserved`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.reserved_address : p.circuit_id_type == null || contains(["hex", "string"], p.circuit_id_type)]]))
    error_message = "Parameter `reserved_address.circuit_id_type` must be one of `hex`, or `string`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp4 : [for p in o.reserved_address : p.remote_id_type == null || contains(["hex", "string"], p.remote_id_type)]]))
    error_message = "Parameter `reserved_address.remote_id_type` must be one of `hex`, or `string`"
  }
}
variable "dhcp6" {
  type = list(object({
    fosid                 = optional(number)
    status                = optional(string)
    rapid_commit          = optional(string)
    lease_time            = optional(number)
    dns_service           = optional(string)
    dns_search_list       = optional(string)
    dns_server1           = optional(string)
    dns_server2           = optional(string)
    dns_server3           = optional(string)
    dns_server4           = optional(string)
    domain                = optional(string)
    subnet                = string
    interface             = string
    delegaed_prefix_route = optional(string)
    options = optional(list(object({
      id         = optional(number)
      code       = number
      type       = optional(string)
      value      = optional(string)
      ip6        = optional(string)
      vci_match  = optional(string)
      vci_string = optional(list(string), [])
    })), [])
    option1               = optional(string)
    option2               = optional(string)
    option3               = optional(string)
    upstream_interface    = optional(string)
    delegated_prefix_iaid = optional(string)
    ip_mode               = optional(string)
    prefix_mode           = optional(string)
    prefix_range = optional(list(object({
      id            = optional(number)
      start_prefix  = string
      end_prefix    = string
      prefix_length = number
    })), [])
    ip_range = optional(list(object({
      id         = optional(number)
      start_ip   = string
      end_ip     = string
      vci_match  = optional(string)
      vci_string = optional(list(string), [])
    })), [])
    dynamic_sort_subtable = optional(string, "natural")
    get_all_tables        = optional(bool, false)
    vdomparam             = optional(string)
    update_if_exists      = optional(bool)
  }))
  description = "DHCPv6 servers to create"
  default     = []

  validation {
    condition     = alltrue([for o in var.dhcp6 : o.status == null || contains(["enable", "disable"], o.status)])
    error_message = "Parameter `status` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp6 : o.rapid_commit == null || contains(["enable", "disable"], o.rapid_commit)])
    error_message = "Parameter `rapid_commit` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp6 : o.dns_service == null || contains(["delegated", "default", "specify"], o.dns_service)])
    error_message = "Parameter `dns_service` must be one of `delegated`, `default`, or `specify`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp6 : o.dns_search_list == null || contains(["delegated", "specify"], o.dns_search_list)])
    error_message = "Parameter `dns_search_list` must be one of `delegated`, or `specify`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp6 : o.delegated_prefix_route == null || contains(["enable", "disable"], o.delegated_prefix_route)])
    error_message = "Parameter `delegated_prefix_route` must be one of `enable`, or `disable`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp6 : o.ip_mode == null || contains(["range", "delegated"], o.ip_mode)])
    error_message = "Parameter `ip_mode` must be one of `range`, or `delegated`"
  }
  validation {
    condition     = alltrue([for o in var.dhcp6 : o.prefix_mode == null || contains(["dhcp6", "ra"], o.prefix_mode)])
    error_message = "Parameter `prefix_mode` must be one of `dhcp6`, or `ra`"
  }

  validation {
    condition     = alltrue(flatten([for o in var.dhcp6 : [for p in o.options : p.type == null || contains(["hex", "string", "ip6", "fqdn"], p.type)]]))
    error_message = "Parameter `options.type` must be one of `hex`, `string`, `ip6`, or `fqdn`"
  }
  validation {
    condition     = alltrue(flatten([for o in var.dhcp6 : [for p in o.options : p.vci_match == null || contains(["enable", "disable"], p.vci_match)]]))
    error_message = "Parameter `options.vci_match` must be one of `enable`, or `disable`"
  }

  validation {
    condition     = alltrue(flatten([for o in var.dhcp6 : [for p in o.ip_range : p.vci_match == null || contains(["enable", "disable"], p.vci_match)]]))
    error_message = "Parameter `ip_range.vci_match` must be one of `enable`, or `disable`"
  }
}
