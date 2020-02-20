terraform {
  required_version = ">= 0.12"
}

variable "gcp_credentials" {
  description = "GCP credentials needed by google provider"
}

variable "gcp_project" {
  description = "GCP project name"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default     = "us-west1"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. us-east1-a"
  default     = "us-west1-b"
}

variable "machine_type" {
  description = "GCP machine type"
  default     = "f1-micro"
}

variable "instance_name" {
  description = "GCP instance name"
  default     = "demo"
}

variable "image" {
  description = "image to build instance from"
  default     = "debian-cloud/debian-9"
}

variable "labels" {
  description = "descriptive labels for instances deployed"
  default = {
    "name" : "demo-compute-instance",
    "owner" : "andy-assareh",
    "ttl" : "1",
  }
}

variable "env" {
  description = "git branch or environment"
}

provider "google" {
  credentials = var.gcp_credentials
  project     = var.gcp_project
  region      = var.gcp_region
}

resource "google_compute_instance" "demo" {
  name         = ${var.instance_name}-${var.env}
  machine_type = var.machine_type
  zone         = var.gcp_zone
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

output "external_ip" {
  value = google_compute_instance.demo.network_interface.0.access_config.0.nat_ip
}
