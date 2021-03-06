google_project_id = "vof-testbed-2" 
region  = "europe-west1" 
zone = "europe-west1-b"
vof_disk_image = "flevian-vof-image-ruby-1507893995" 
machine_type = "n1-standard-1" 
env_name = "development"
ip_cidr_range = "10.0.0.0/24"
max_instances = 2
min_instances = 1
healthy_threshold = 1
unhealthy_threshold = 5
timeout_sec = 3
check_interval_sec = 5
request_path = "/login"
vof_disk_size = 10
vof_disk_type = "pd-ssd"
database_charset   = "UTF8"
database_collation = "en_US.UTF8"
database_disk_type = "PD_SSD"
database_activation_policy = "ALWAYS"
database_pricing_plan = "PER_USE"
database_disk_size = 10
database_machine_type_tier = "D0"
database_region = "europe-west1"
database_backup_binary_log_enabled = "true"
database_backup_enabled = "true"
database_backup_start_time = "00:12"
database_failover_target = "true"
database_connect_retry_interval = 40
database_master_replica_name = "vof-replica-master"
database_master_replica_password = "vof-replica"
database_host_name = "vof-tracker-dev.andela.com"

