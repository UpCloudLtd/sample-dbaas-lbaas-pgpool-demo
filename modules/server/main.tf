resource "upcloud_server" "sql-client" {
  hostname   = "sql-client"
  zone       = var.zone
  plan       = "1xCPU-1GB"
  metadata   = true
  depends_on = [var.private_sdn_network_client, var.dbaas_pgsql_username]

  template {
    storage = "Ubuntu Server 22.04 LTS (Jammy Jellyfish)"
    size    = 25
  }
  network_interface {
    type = "public"
  }
  network_interface {
    type    = "private"
    network = var.private_sdn_network_client
  }

  login {
    user = "root"
    keys = [
      var.ssh_key_public,
    ]
    create_password   = false
    password_delivery = "email"
  }

  connection {
    host  = self.network_interface[0].ip_address
    type  = "ssh"
    user  = "root"
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get -y install sysbench postgresql-client",
      "echo 'sysbench /usr/share/sysbench/oltp_read_write.lua --threads=1 --pgsql-host=$1 --pgsql-user=${var.dbaas_pgsql_username} --pgsql-password=${var.dbaas_pgsql_password} --pgsql-port=5432 --pgsql-db=${var.dbaas_pgsql_database} --db-driver=pgsql --tables=20 --table-size=200000  prepare' > /root/prepare-benchmark",
      "echo 'sysbench /usr/share/sysbench/oltp_read_write.lua --threads=1 --pgsql-host=$1 --pgsql-user=${var.dbaas_pgsql_username} --pgsql-password=${var.dbaas_pgsql_password} --pgsql-port=5432 --pgsql-db=${var.dbaas_pgsql_database} --db-driver=pgsql --tables=20 --table-size=200000 --report-interval=10 --time=30 run' > /root/run-benchmark",
      "echo 'while true; do PGPASSWORD=${var.dbaas_pgsql_password} psql -p5432 -U${var.dbaas_pgsql_username} -h $1 ${var.dbaas_pgsql_database} -c \"select inet_server_addr();\"; sleep 1; done' > /root/ping-psql.sh",
      "echo 'PGPASSWORD=${var.dbaas_pgsql_password} psql -p5432 -U${var.dbaas_pgsql_username} -h $1 ${var.dbaas_pgsql_database} -c \"show pool_nodes;\";' > show-servers.sh"
    ]
  }
}
