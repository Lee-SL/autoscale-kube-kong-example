resource "google_storage_bucket" "kong-kube-terraform-state" {
  name          = "${var.bucket-name}"
  location      = "${var.region}"
  storage_class = "${var.storage-class}"
  force_destroy = true
}
