resource "upcloud_network" "private_sdn_network_proxy" {
  name = "pgpool_sdn_network"
  zone = var.zone

  ip_network {
    address            = "10.10.12.0/24"
    dhcp               = true
    dhcp_default_route = false
    family             = "IPv4"
  }
}

resource "upcloud_network" "private_sdn_network_client" {
  name = "client_sdn_network"
  zone = var.zone

  ip_network {
    address            = "10.10.22.0/24"
    dhcp               = true
    dhcp_default_route = false
    family             = "IPv4"
  }
}

resource "upcloud_router" "psql_be_router" {
  name = "psql_be_router"
}
resource "upcloud_network" "private_psql_be" {
  name   = "psql-backend-network"
  zone   = var.zone
  router = upcloud_router.psql_be_router.id
  ip_network {
    address            = "10.10.32.0/24"
    dhcp               = true
    dhcp_default_route = false
    family             = "IPv4"
  }
}