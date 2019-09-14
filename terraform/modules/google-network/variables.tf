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

variable "google_ssh_ip_cidr_ranges" {
  description = "IP CIDR to allow SSH from"
}

variable "google_cidr_range" {
  description = "Main VPC CIDR range"
}

variable "google_subnetwork_secondary_ip_cidr_ranges" {
  description = "Secondary IP CIDR ranges to add to the subnetwork"
}
