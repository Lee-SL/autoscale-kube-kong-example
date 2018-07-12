provider "google" {
  credentials = "${file("${path.module}/../credentials/key.json")}"
  project     = "${var.project-id}"
  region      = "${var.region}"
}
