#
# VPC.
#

provider "google" {
  region = var.google_region
  zone   = var.google_primary_zone
}

provider "google-beta" {
  region = var.google_region
  zone   = var.google_primary_zone
}

resource "google_compute_network" "vpc" {
  name                    = "vpc-${var.suffix}"
  project                 = var.google_project_name
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = "false"
}

resource "google_compute_project_metadata_item" "ssh_key" {
  project    = var.google_project_name
  key        = "ssh-key"
  value      = var.google_ssh_public_key
}

resource "google_compute_router" "vpc_router" {
  name       = "router-${var.suffix}"
  project    = var.google_project_name
  region     = var.google_region
  network    = google_compute_network.vpc.self_link
}

resource "google_compute_firewall" "firewall" {
  name          = "firewall-${var.suffix}"
  project       = var.google_project_name
  network       = google_compute_network.vpc.self_link
  source_ranges = [var.google_ssh_ip_cidr]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_subnetwork" "subnetwork" {
  name                     = "subnetwork-${var.suffix}"
  project                  = var.google_project_name
  region                   = var.google_region
  network                  = google_compute_network.vpc.self_link
  private_ip_google_access = true
  ip_cidr_range            = var.google_cidr_block

  secondary_ip_range = concat(
    [
      {
        range_name    = "public-services"
        ip_cidr_range = var.google_bastion_cidr_block
      }
    ],
      var.google_subnetwork_secondary_ip_cidr_blocks
    )
}

resource "google_compute_address" "nat" {
  name       = "nat-ip-${var.suffix}"
  project    = var.google_project_name
  region     = var.google_region
}

resource "google_compute_router_nat" "vpc_nat" {
  name                               = "nat-${var.suffix}"
  project                            = var.google_project_name
  region                             = var.google_region
  router                             = google_compute_router.vpc_router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnetwork.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
