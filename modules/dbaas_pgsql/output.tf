output "dbaas_pgsql_hosts" {
  value = [upcloud_managed_database_postgresql.dbaas_pgsql.components[0].host, upcloud_managed_database_postgresql.dbaas_pgsql.components[1].host]
}
output "dbaas_pgsql_port" {
  value = upcloud_managed_database_postgresql.dbaas_pgsql.service_port
}
output "dbaas_pgsql_password" {
  value = upcloud_managed_database_user.testuser.password
}
output "dbaas_pgsql_username" {
  value = upcloud_managed_database_user.testuser.username
}
output "dbaas_pgsql_monitor_password" {
  value = upcloud_managed_database_user.monitor.password
}
output "dbaas_pgsql_monitor_username" {
  value = upcloud_managed_database_user.monitor.username
}
output "dbaas_pgsql_default_password" {
  value = upcloud_managed_database_postgresql.dbaas_pgsql.service_password
}
output "dbaas_pgsql_default_username" {
  value = upcloud_managed_database_postgresql.dbaas_pgsql.service_username
}
output "dbaas_pgsql_database" {
  value = upcloud_managed_database_logical_database.testdb.name
}