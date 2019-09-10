#
# DNS Subdomain Zone.
#

provider "google" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

provider "google-beta" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

resource "google_dns_managed_zone" "subdomain" {
  name       = "${var.gcp_dns_subdomain}-zone-${var.suffix}"
  dns_name   = "${var.gcp_dns_subdomain}.${var.gcp_dns_domain}."
  project    = var.gcp_project_name
}

resource "google_dns_record_set" "ns" {
  name         = google_dns_managed_zone.subdomain.dns_name
  managed_zone = var.gcp_dns_root_zone
  project      = var.gcp_admin_project_name
  rrdatas      = google_dns_managed_zone.subdomain.name_servers
  type         = "NS"
  ttl          = 300
}
