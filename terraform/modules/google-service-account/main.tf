#
# Service Account.
#

provider "google" {
  region = var.google_region
  zone   = var.google_primary_zone
}

provider "google-beta" {
  region = var.google_region
  zone   = var.google_primary_zone
}

resource "google_service_account" "service_account" {
  account_id   = "${var.google_service_account_name}-${var.suffix}"
  display_name = "${var.google_service_account_name}-${var.suffix}"
  project      = var.google_project_name
}

resource "google_project_iam_member" "member" {
  for_each = toset(var.google_service_account_roles)

  project = var.google_project_name
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
