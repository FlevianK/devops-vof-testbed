resource "google_sql_database_instance" "vof-master-database" {
  name = "${var.env_name}-vof-master-database"
  region = "${var.database_region}"
  master_instance_name = "${var.env_name}-vof-master-database-instance"

  settings {
    tier = "${var.database_machine_type_tier}"
    replication_type = "SYNCHRONOUS"
    disk_type = "${var.database_disk_type}"
    activation_policy = "${var.database_activation_policy}"
    pricing_plan = "${var.database_pricing_plan}"
    disk_size = "${var.database_disk_size}"

    backup_configuration {
      binary_log_enabled = "${var.database_backup_binary_log_enabled}"
      enabled = "${var.database_backup_enabled}"
      start_time = "${var.database_backup_start_time}"
    }
  }

  replica_configuration {
    failover_target = "${var.database_failover_target}"
    connect_retry_interval = "${var.database_connect_retry_interval}"
    username = "${var.database_master_replica_name}"
    password = "${var.database_master_replica_password}"
  }
}

resource "google_sql_database" "vof-database" {
  name = "${var.env_name}-vof-database"
  instance = "${google_sql_database_instance.vof-master-database.name}"
  charset = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "vof-db-user" {
  instance = "${google_sql_database_instance.vof-master-database.name}"
  host = "${var.database_host_name}"
  name = "${random_id.db-username.hex}"
  password = "${random_id.db-password.hex}"
}

resource "random_id" "db-username" {
  byte_length = 16
}

resource "random_id" "db-password" {
  byte_length = 16
}

output "vof-db-username" {
  value = "${random_id.db-username.hex}"
}

output "vof-db-password" {
  value = "${random_id.db-password.hex}"
}
