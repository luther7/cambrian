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

variable "gcp_ssh_ip_cidr" {
  description = "IP CIDR to allow SSH from"
}

variable "gcp_ssh_public_key" {
  description = "Public SSH key"
}

variable "gcp_cidr_block" {
  description = "Main VPC CIDR block"
}

variable "gcp_bastion_cidr_block" {
  description = "Bastion CIDR block"
}

variable "gcp_subnetwork_secondary_ip_ranges" {
  description = "Secondary IP ranges to add to the subnetwork"
}
