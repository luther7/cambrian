#
# Bastion.
#

provider "google" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

provider "google-beta" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

resource "google_compute_address" "bastion" {
  name       = "bastion-ip-${var.suffix}"
  project    = var.gcp_project_name
  region     = var.gcp_region
}

resource "google_compute_instance" "bastion" {
  name         = "bastion-${var.suffix}"
  project      = var.gcp_project_name
  zone         = var.gcp_primary_zone
  machine_type = var.gcp_bastion_machine_type

  boot_disk {
    initialize_params {
      image = var.gcp_bastion_source_image
    }
  }

  metadata = {
    enable-oslogin         = "TRUE"
    block-project-ssh-keys = var.gcp_bastion_block_project_ssh_keys
  }

  network_interface {
    subnetwork = var.gcp_vpc_subnetwork

    access_config {
      nat_ip = google_compute_address.bastion.address
    }
  }
}
