#
# Variables.
#

variable "suffix" {
  description = "A suffix appended to all resources across this environment"
}

variable "google_region" {
  description = "Region"
}

variable "google_primary_zone" {
  description = "Primary zone"
}

variable "google_project_name" {
  description = "Project name"
}

variable "google_organization_id" {
  description = "Organization ID"
}

variable "google_billing_account_id" {
  description = "Billing ID"
}

variable "google_admin_project_name" {
  description = "Admin project name"
}

variable "google_service_account_name" {
  description = "Service account name"
}

