
module "dbaas_pgsql" {
  source     = "./modules/dbaas_pgsql"
  dbaas_plan = var.dbaas_plan
  zone       = var.zone
}
module "sdn_network" {
  source = "./modules/sdn_network"
  zone   = var.zone
}

module "proxy" {
  source                       = "./modules/proxy"
  ssh_key_public               = var.ssh_key_public
  zone                         = var.zone
  pgpool_proxy_plan            = var.pgpool_proxy_plan
  private_sdn_network          = module.sdn_network.private_sdn_network
  dbaas_pgsql_hosts            = module.dbaas_pgsql.dbaas_pgsql_hosts
  dbaas_pgsql_database         = module.dbaas_pgsql.dbaas_pgsql_database
  dbaas_pgsql_port             = module.dbaas_pgsql.dbaas_pgsql_port
  dbaas_pgsql_username         = module.dbaas_pgsql.dbaas_pgsql_username
  dbaas_pgsql_password         = module.dbaas_pgsql.dbaas_pgsql_password
  dbaas_pgsql_default_username = module.dbaas_pgsql.dbaas_pgsql_default_username
  dbaas_pgsql_default_password = module.dbaas_pgsql.dbaas_pgsql_default_password
  dbaas_pgsql_monitor_username = module.dbaas_pgsql.dbaas_pgsql_monitor_username
  dbaas_pgsql_monitor_password = module.dbaas_pgsql.dbaas_pgsql_monitor_password
}

module "server" {
  source               = "./modules/server"
  ssh_key_public       = var.ssh_key_public
  private_sdn_network  = module.sdn_network.private_sdn_network
  zone                 = var.zone
  dbaas_pgsql_database = module.dbaas_pgsql.dbaas_pgsql_database
  dbaas_pgsql_username = module.dbaas_pgsql.dbaas_pgsql_username
  dbaas_pgsql_password = module.dbaas_pgsql.dbaas_pgsql_password
}

module "loadbalancer" {
  source                     = "./modules/loadbalancer"
  zone                       = var.zone
  proxy_private_ip_addresses = module.proxy.proxy_private_ip_addresses
  private_sdn_network        = module.sdn_network.private_sdn_network
  sql_client_ip_address      = module.server.sql_client_ip_address
}