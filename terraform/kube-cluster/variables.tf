variable "region" {
  default = "australia-southeast1" # Sydney
}

variable "zone" {
  default {
    "a" = "australia-southeast1-a"
    "b" = "australia-southeast1-b"
    "c" = "australia-southeast1-c"
  }
}

variable "network" {
  default = "kong-network"
}

variable "project-id" {
  default = "kube-showcase-kong"
}

variable "cluster" {
  default {
    "name"               = "kong-cluster-showcase"
    "version"            = "1.10.4-gke.2"
    "initial-node-count" = 1
    "disable_dashboard"  = true
  }
}

variable "node" {
  default {
    "image-type"     = "COS"
    "machine-type"   = "n1-standard-2"
    "boot-disk-size" = 20
    "autoscaling"    = true
    "min-node-count" = 1
    "max-node-count" = 4
  }
}
