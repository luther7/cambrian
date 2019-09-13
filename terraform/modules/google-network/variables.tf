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

variable "google_ssh_ip_cidr" {
  description = "IP CIDR to allow SSH from"
}

variable "google_ssh_public_key" {
  description = "Public SSH key"
}

variable "google_cidr_block" {
  description = "Main VPC CIDR block"
}

variable "google_bastion_cidr_block" {
  description = "Bastion CIDR block"
}

variable "google_subnetwork_secondary_ip_cidr_blocks" {
  description = "Secondary IP CIDR blocks to add to the subnetwork"
}
