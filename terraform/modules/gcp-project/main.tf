#
# Project.
#

provider "google" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

provider "google-beta" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

resource "google_project" "project" {
  name            = "${var.gcp_project_name}-${var.suffix}"
  project_id      = "${var.gcp_project_name}-${var.suffix}"
  org_id          = var.gcp_organization_id
  billing_account = var.gcp_billing_account_id
}

resource "google_project_iam_member" "owner" {
  project    = google_project.project.project_id
  role       = "roles/owner"
  member     = "serviceAccount:${var.gcp_service_account_name}@${var.gcp_admin_project_name}.iam.gserviceaccount.com"
}

resource "google_project_service" "service" {
  for_each = toset(var.gcp_project_services)

  service                    = each.value
  project                    = google_project.project.project_id
  disable_dependent_services = true
}
