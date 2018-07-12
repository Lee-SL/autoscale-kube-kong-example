variable "region" {
  default = "australia-southeast1" # Sydney
}

variable "storage-class" {
  default = "REGIONAL"
}

variable "project-id" {
  default = "kube-showcase-kong"
}

variable "bucket-name" {
  default = "kong-kube-terraform-state"
}

variable "bucket-path" {
  default = "tf_state/terraform.tfstate"
}
