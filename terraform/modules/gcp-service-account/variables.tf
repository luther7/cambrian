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

variable "gcp_service_account_name" {
  description = "GCP service account name"
}

variable "gcp_service_account_roles" {
  description = "Roles to add to the service account"
}
