resource "google_compute_firewall" "vof-internal-firewall" {
  name = "${var.env_name}-vof-internal-network"
  network = "${google_compute_network.vof-network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports = ["0-65535"]
  }

  source_ranges = ["{var.ip_cidr_range}"]
}

resource "google_compute_firewall" "vof-public-firewall" {
  name = "${var.env_name}-vof-public-firewall"
  network = "{google_compute_network.vof-network.name}"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["${var.env_name}-vof-lb"]
}
