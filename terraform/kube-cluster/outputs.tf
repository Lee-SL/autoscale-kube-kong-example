output cluster-name {
  description = "Kong cluster created"
  value       = "${google_container_cluster.kong-cluster.name}"
}
