#
# Variables.
#

variable "suffix" {
  description = "A suffix appended to all resources across this environment"
}

variable "gcp_region" {
  description = "GCP region"
}

variable "gcp_primary_zone" {
  description = "GCP primary zone"
}

variable "gcp_project_name" {
  description = "GCP project name"
}

variable "gcp_organization_id" {
  description = "GCP organization ID"
}

variable "gcp_billing_account_id" {
  description = "GCP billing ID"
}

variable "gcp_project_services" {
  description = "GCP project services"
}

variable "gcp_admin_project_name" {
  description = "GCP admin project name"
}

variable "gcp_service_account_name" {
  description = "GCP service account name"
}

