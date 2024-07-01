output "proxy_ip_addresses" {
  value = [
    upcloud_server.proxy-server[0].network_interface[0].ip_address,
    upcloud_server.proxy-server[1].network_interface[0].ip_address
  ]
}

output "proxy_private_ip_addresses" {
  value = [
    upcloud_server.proxy-server[0].network_interface[1].ip_address,
    upcloud_server.proxy-server[1].network_interface[1].ip_address
  ]
}