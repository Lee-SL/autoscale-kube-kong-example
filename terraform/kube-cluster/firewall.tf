resource "google_compute_firewall" "ssh" {
  name    = "${var.network}-firewall-ssh"
  network = "${google_compute_network.kong-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.network}-firewall-ssh"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "icmp" {
  name    = "${var.network}-firewall-icmp"
  network = "${google_compute_network.kong-network.name}"

  allow {
    protocol = "icmp"
  }

  target_tags   = ["${var.network}-firewall-icmp"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "internal" {
  name    = "${var.network}-firewall-internal"
  network = "${google_compute_network.kong-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  target_tags   = ["${var.network}-firewall-internal"]
  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_firewall" "rdp" {
  name    = "${var.network}-firewall-rdp"
  network = "${google_compute_network.kong-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  target_tags   = ["${var.network}-firewall-rdp"]
  source_ranges = ["0.0.0.0/0"]
}

# resource "google_compute_firewall" "postgresql" {
#   name    = "${var.network}-firewall-postgresql"
#   network = "${google_compute_network.sample_network.name}"


#   allow {
#     protocol = "tcp"
#     ports    = ["5432"]
#   }


#   target_tags   = ["${var.network}-firewall-postgresql"]
#   source_ranges = ["0.0.0.0/0"]
# }

