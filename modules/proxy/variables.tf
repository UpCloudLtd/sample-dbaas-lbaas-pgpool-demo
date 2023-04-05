variable "ssh_key_public" {
  type = string
}

variable "zone" {
  type = string
}

variable "pgpool_proxy_plan" {
  type = string
}

variable "private_sdn_network_proxy" {
  type = string
}

variable "dbaas_pgsql_hosts" {
  type = list(any)
}

variable "dbaas_pgsql_port" {
  type = string
}

variable "dbaas_pgsql_username" {
  type = string
}

variable "dbaas_pgsql_password" {
  type = string
}

variable "dbaas_pgsql_default_username" {
  type = string
}

variable "dbaas_pgsql_default_password" {
  type = string
}

variable "dbaas_pgsql_monitor_username" {
  type = string
}

variable "dbaas_pgsql_monitor_password" {
  type = string
}

variable "dbaas_pgsql_database" {
  type = string
}
