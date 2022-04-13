variable "private_sdn_network" {
  type    = string
  default = ""
}

variable "zone" {
  type = string
}

variable "dbaas_plan" {
  type = string
}

variable "pgpool_proxy_plan" {
  type = string
}

variable "ssh_key_public" {
  type = string
}

variable "proxy_sdn_ip" {
  type    = string
  default = ""
}

variable "proxy_private_ip_addresses" {
  type    = list(any)
  default = [""]
}

variable "dbaas_pgsql_hosts" {
  type    = list(any)
  default = [""]
}

variable "dbaas_pgsql_port" {
  type    = string
  default = ""
}

variable "dbaas_pgsql_database" {
  type    = string
  default = ""
}

variable "dbaas_pgsql_username" {
  type    = string
  default = ""
}

variable "dbaas_pgsql_password" {
  type    = string
  default = ""
}

variable "dbaas_pgsql_monitor_username" {
  type    = string
  default = ""
}

variable "dbaas_pgsql_monitor_password" {
  type    = string
  default = ""
}

variable "dbaas_pgsql_default_username" {
  type    = string
  default = ""
}

variable "dbaas_pgsql_default_password" {
  type    = string
  default = ""
}
