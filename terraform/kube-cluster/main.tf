resource "google_container_cluster" "kong-cluster" {
  name   = "${var.cluster["name"]}"
  region = "${var.region}"

  addons_config {
    kubernetes_dashboard {
      disabled = "${var.cluster["disable_dashboard"]}"
    }
  }

  network = "${var.network}"

  node_pool {
    name               = "default-pool"
    initial_node_count = "${var.cluster["initial-node-count"]}"

    autoscaling {
      min_node_count = "${var.node["min-node-count"]}"
      max_node_count = "${var.node["max-node-count"]}"
    }

    node_config {
      image_type   = "${var.node["image-type"]}"
      machine_type = "${var.node["machine-type"]}"
      disk_size_gb = "${var.node["boot-disk-size"]}"

      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/trace.append",
      ]

      # Tags can used to identify targets in firewall rules
      tags = [
        "${var.network}-firewall-ssh",
        "${var.network}-firewall-icmp",
        "${var.network}-firewall-internal",
        "${var.network}-firewall-rdp",
      ]
    }
  }
}
