resource "random_id" "db-name" {
  byte_length = 8
}

resource "random_id" "db-master-name" {
  byte_length = 8
}
resource "random_id" "db-instance" {
  byte_length = 8
}

resource "random_id" "vof-db-user-password" {
  byte_length = 16
}

resource "google_sql_database_instance" "vof-master-database-instance" {
  region = "${var.region}"
  database_version = "POSTGRES_9_6"
  name = "${var.env_name}-vof-master-database-instance"
  #master_instance_name = "${var.env_name}-vof-database-master-instance-${replace(lower(random_id.db-master-name.b64), "_", "-")}"

  settings {
    tier = "${var.db_instance_tier}"
    #replication_type = "SYNCHRONOUS"
    disk_type = "${var.database_disk_type}"
    activation_policy = "${var.database_activation_policy}"
    pricing_plan = "${var.database_pricing_plan}"
    disk_size = "${var.database_disk_size}"
    #crash_safe_replication = true
    ip_configuration = {
      ipv4_enabled = true

      authorized_networks = [{
        name = "all"
        value = "0.0.0.0/0"
      }]
    }
    #backup_configuration {
    #  binary_log_enabled = true
    #  enabled = true
    #  start_time = "${var.database_backup_start_time}"
    #}
  }
} 

resource "google_sql_database" "vof-database" {
  name = "vof-database-flev"
  instance = "${google_sql_database_instance.vof-master-database-instance.name}"
  charset = "${var.database_charset}"
  collation = "${var.database_collation}"
}

resource "google_sql_user" "vof-database-user" {
  name = "${var.env_name}-vof-database-user"
  password = "${random_id.vof-db-user-password.b64}"
  instance = "${google_sql_database_instance.vof-master-database-instance.name}"
  host = "${var.vof_host}"
}

#resource "random_id" "database_master_replica_password" {
#  byte_length = 16
#}

#output "vof-database_master_replica_password" {
#  value = "${random_id.database_master_replica_password.hex}"
#}

output "vof_db_user_password" {
  value = "${random_id.vof-db-user-password.b64}"
}

output "vof_db_instance_ip" {
  value = "${google_sql_database_instance.vof-master-database-instance.ip_address.0.ip_address}"
}