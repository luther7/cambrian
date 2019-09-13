#
# Bastion.
#

provider "google" {
  region = var.google_region
  zone   = var.google_primary_zone
}

provider "google-beta" {
  region = var.google_region
  zone   = var.google_primary_zone
}

resource "google_compute_address" "bastion" {
  name       = "bastion-ip-${var.suffix}"
  project    = var.google_project_name
  region     = var.google_region
}

resource "google_compute_instance" "bastion" {
  name         = "bastion-${var.suffix}"
  project      = var.google_project_name
  zone         = var.google_primary_zone
  machine_type = var.google_bastion_machine_type

  boot_disk {
    initialize_params {
      image = var.google_bastion_source_image
    }
  }

  metadata = {
    enable-oslogin         = "TRUE"
    block-project-ssh-keys = var.google_bastion_block_project_ssh_keys
  }

  network_interface {
    subnetwork = var.google_subnetwork

    access_config {
      nat_ip = google_compute_address.bastion.address
    }
  }
}
