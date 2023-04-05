resource "upcloud_server" "proxy-server" {
  zone       = var.zone
  plan       = var.pgpool_proxy_plan
  count      = 2
  metadata   = true
  hostname   = "pgpool-proxy${count.index}-server"
  depends_on = [var.private_sdn_network_proxy, var.dbaas_pgsql_hosts]

  template {
    storage = "Ubuntu Server 22.04 LTS (Jammy Jellyfish)"
    size    = 25
  }

  network_interface {
    type = "public"
  }
  network_interface {
    type = "utility"
  }
  network_interface {
    type    = "private"
    network = var.private_sdn_network_proxy
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
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update",
      "apt-get -o 'Dpkg::Options::=--force-confold' -q -y upgrade",
      "apt-get -o 'Dpkg::Options::=--force-confold' -q -y install pgpool2 postgresql-client memcached",
      "systemctl enable --now pgpool2"
    ]
  }
  provisioner "file" {
    content = templatefile("configs/pgpool.conf.tftpl", {
      SERVER0                = var.dbaas_pgsql_hosts[0],
      SERVER1                = var.dbaas_pgsql_hosts[1],
      DBAAS_MONITOR_USER     = var.dbaas_pgsql_monitor_username,
      DBAAS_MONITOR_PASSWORD = var.dbaas_pgsql_monitor_password,
      DBAAS_DATABASE         = var.dbaas_pgsql_database,
    DBAAS_PORT = var.dbaas_pgsql_port })
    destination = "/etc/pgpool2/pgpool.conf"
  }
  provisioner "file" {
    source      = "configs/pool_hba.conf.tftpl"
    destination = "/etc/pgpool2/pool_hba.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "cd /etc/pgpool2",
      "pg_md5 --md5auth --username=${var.dbaas_pgsql_username} ${var.dbaas_pgsql_password}",
      "pg_md5 --md5auth --username=${var.dbaas_pgsql_monitor_username} ${var.dbaas_pgsql_monitor_password}",
      "echo \"manager:$(pg_md5 ${var.dbaas_pgsql_default_password})\" >> pcp.conf",
      "systemctl stop pgpool2",
      "rm /var/log/postgresql/pgpool_status",
      "sleep 10",
      "systemctl enable --now pgpool2"
    ]
  }
}

resource "upcloud_server_group" "proxy-ha-pair" {
  title         = "proxy_ha_group"
  anti_affinity = true
  labels = {
    "key1" = "proxy-ha"

  }
  members = [
    upcloud_server.proxy-server[0].id,
    upcloud_server.proxy-server[1].id
  ]

}