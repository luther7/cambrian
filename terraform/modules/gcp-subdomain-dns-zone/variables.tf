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

variable "gcp_admin_project_name" {
  description = "GCP admin project name"
}

variable "gcp_dns_root_zone" {
  description = "Root DNS zone"
}

variable "gcp_dns_domain" {
  description = "DNS domain"
}

variable "gcp_dns_subdomain" {
  description = "DNS subdomain"
}
