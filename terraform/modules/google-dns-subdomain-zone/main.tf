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
  service                    = "dns.googleapis.com"
  project                    = var.google_project_name
  disable_dependent_services = true
}

resource "google_dns_managed_zone" "subdomain" {
  name       = "${var.google_dns_subdomain}-zone-${var.suffix}"
  dns_name   = "${var.google_dns_subdomain}.${var.google_dns_domain}."
  project    = var.google_project_name

  depends_on = [google_project_service.service]
}

resource "google_dns_record_set" "ns" {
  name         = "${var.google_dns_subdomain}.${var.google_dns_domain}."
  managed_zone = var.google_dns_root_zone
  project      = var.google_admin_project_name
  rrdatas      = google_dns_managed_zone.subdomain.name_servers
  type         = "NS"
  ttl          = 300
}
