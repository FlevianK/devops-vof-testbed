resource "google_compute_global_address" "vof-entrance-ip" {
  name = "${var.env_name}-vof-entrance-ip"
}
 
resource "google_compute_global_forwarding_rule" "vof-http" {
  name= "${var.env_name}-vof-http"
  ip_address = "${google_compute_global_address.vof-entrance-ip.address}"
  target = "${google_compute_target_http_proxy.vof-http-proxy.self_link}"
  port_range = "80"
} 

resource "google_compute_target_http_proxy" "vof-http-proxy" {
  name = "${var.env_name}-vof-http-proxy"
  url_map = "${google_compute_url_map.vof-http-url-map.self_link}"
}

resource "google_compute_url_map" "vof-http-url-map" {
  name = "${var.env_name}-vof-http-url-map"
  default_service = "${google_compute_backend_service.website.self_link}"
}

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

  source_ranges = ["${var.ip_cidr_range}"]
  target_tags = ["${var.env_name}-vof-lb"]
}

resource "google_compute_firewall" "vof-public-firewall" {
  name = "${var.env_name}-vof-public-firewall"
  network = "${google_compute_network.vof-network.name}"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["${var.env_name}-vof-lb"]
}
