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

variable "google_subnetwork" {
  description = "Subnetwork"
}

variable "google_bastion_machine_type" {
  description = "Bastion machine type"
  default     = "f1-micro"
}

variable "google_bastion_source_image" {
  description = "Bastion source image"
  default     = "gce-uefi-images/ubuntu-1804-lts"
}

variable "google_bastion_block_project_ssh_keys" {
  description = "Whether to block project SSH keys"
  default     = false
}
