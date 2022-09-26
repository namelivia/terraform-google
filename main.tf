terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "=4.37.0"
    }
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "g1-small"
  tags = ["http-server", "https-server", "openvpn"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_key}"
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}
