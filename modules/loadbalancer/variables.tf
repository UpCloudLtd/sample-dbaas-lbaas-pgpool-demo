
variable "zone" {
  type = string
}

variable "private_sdn_network_client" {
  type = string
}
variable "private_sdn_network_client_address" {
  type = string
}
variable "private_sdn_network_proxy" {
  type = string
}
variable "proxy_private_ip_addresses" {
  type = list(any)
}
