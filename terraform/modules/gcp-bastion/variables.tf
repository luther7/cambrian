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

variable "gcp_bastion_machine_type" {
  description = "Bastion machine type"
  default     = "f1-micro"
}

variable "gcp_bastion_source_image" {
  description = "Bastion source image"
  default     = "gce-uefi-images/ubuntu-1804-lts"
}

variable "gcp_bastion_block_project_ssh_keys" {
  description = "Whether to block project SSH keys"
  default     = false
}

variable "gcp_vpc_subnetwork" {
  description = "VPC subnetwork"
}
