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

variable "google_admin_project_name" {
  description = "Admin project name"
}

variable "google_dns_root_zone" {
  description = "Root DNS zone"
}

variable "google_dns_domain" {
  description = "DNS domain"
}

variable "google_dns_subdomain" {
  description = "DNS subdomain"
}
