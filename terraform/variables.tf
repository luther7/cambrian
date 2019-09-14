#
# Variables.
#

#
# Google.
#

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

variable "google_organization_id" {
  description = "Organization ID"
}

variable "google_billing_account_id" {
  description = "Billing ID"
}

variable "google_service_account_name" {
  description = "Service account name"
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

variable "google_ssh_ip_cidr_ranges" {
  description = "IP CIDR ranges to allow SSH from"
}

variable "google_ssh_public_key" {
  description = "Public SSH key"
}

variable "google_kube_api_ip_cidr_ranges" {
  description = "IP CIDR ranges allowed to access the Kubernetes API"
}

variable "google_service_account_roles" {
  description = "Roles to add to the service account"

  default = [
    "roles/storage.admin",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ]
}

variable "google_cidr_range" {
  description = "Main VPC CIDR range"
  default     = "10.0.0.0/16"
}

variable "google_bastion_cidr_range" {
  description = "CIDR range for bastions"
  default     = "192.168.1.0/24"
}

variable "google_subnetwork_secondary_ip_cidr_ranges" {
  description = "Secondary IP CIDR ranges to add to the subnetwork"

  default = [
    {
      range_name    = "services",
      ip_cidr_range = "10.2.0.0/20"
    },
    {
      range_name    = "pods",
      ip_cidr_range = "10.4.0.0/14"
    }
  ]
}

variable "google_kube_master_cidr_range" {
  description = "Kubernetes master CIDR range"
  default     = "10.8.0.0/28"
}

variable "google_kube_node_pool_min_count" {
  description = "Kubernetes node pool min count"
  default     = 2
}

variable "google_kube_node_pool_max_count" {
  description = "Kubernetes node pool max count"
  default     = 2
}

variable "google_kube_node_machine_type" {
  description = "Kubernetes node machine type"
  default     = "n1-standard-2"
}
