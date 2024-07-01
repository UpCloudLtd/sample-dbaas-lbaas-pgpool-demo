output "private_sdn_network_proxy" {
  value = upcloud_network.private_sdn_network_proxy.id
}
output "private_sdn_network_client" {
  value = upcloud_network.private_sdn_network_client.id
}

output "private_sdn_network_client_address" {
  value = upcloud_network.private_sdn_network_client.ip_network[0].address
}

output "private_sdn_network_be" {
  value = upcloud_network.private_psql_be.id
}