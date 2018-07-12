resource "google_compute_network" "kong-network" {
  name                    = "${var.network}"
  auto_create_subnetworks = "true"
}
