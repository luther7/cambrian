#
# Project.
#

provider "google" {
  region = var.google_region
  zone   = var.google_primary_zone
}

provider "google-beta" {
  region = var.google_region
  zone   = var.google_primary_zone
}

resource "google_project" "project" {
  name            = "${var.google_project_name}-${var.suffix}"
  project_id      = "${var.google_project_name}-${var.suffix}"
  org_id          = var.google_organization_id
  billing_account = var.google_billing_account_id
}

resource "google_project_service" "service" {
  for_each = toset([
    "compute.googleapis.com",
    "iam.googleapis.com"
  ])

  service                    = each.value
  project                    = google_project.project.project_id
  disable_dependent_services = true
}

resource "google_project_iam_member" "owner" {
  project    = google_project.project.project_id
  role       = "roles/owner"
  member     = "serviceAccount:${var.google_service_account_name}@${var.google_admin_project_name}.iam.gserviceaccount.com"

  depends_on = [google_project_service.service]
}

resource "google_compute_project_metadata_item" "ssh_key" {
  project    = google_project.project.project_id
  key        = "ssh-key"
  value      = var.google_ssh_public_key

  depends_on = [google_project_service.service]
}
