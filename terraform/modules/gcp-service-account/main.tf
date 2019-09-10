#
# Service Account.
#

provider "google" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

provider "google-beta" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

resource "google_service_account" "service_account" {
  account_id   = "${var.gcp_service_account_name}-${var.suffix}"
  display_name = "${var.gcp_service_account_name}-${var.suffix}"
  project      = var.gcp_project_name
}

resource "google_project_iam_member" "member" {
  for_each = toset(var.gcp_service_account_roles)

  project = var.gcp_project_name
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
