#
# DNS Subdomain Zone.
#

provider "google" {
  region = var.google_region
  zone   = var.google_primary_zone
}

provider "google-beta" {
  region = var.google_region
  zone   = var.google_primary_zone
}

resource "google_project_service" "service" {
  for_each = toset([
    "compute.googleapis.com",
    "dns.googleapis.com"
  ])

  service                    = each.value
  project                    = var.google_project_name
  disable_dependent_services = true
}

resource "google_compute_address" "address" {
  name    = "address-${var.suffix}"
  project = var.google_project_name
  region  = var.google_region

  depends_on = [google_project_service.service]
}

resource "google_dns_record_set" "record" {
  name         = var.google_dns_record_name
  rrdatas      = [google_compute_address.address.address]
  managed_zone = var.google_dns_zone
  project      = var.google_project_name
  type         = "A"
  ttl          = 300
}
