#
# Variables.
#

#
# GCP.
#

variable "gcp_project_name" {
  description = "GCP project name"
}

variable "gcp_region" {
  description = "GCP region"
}

variable "gcp_primary_zone" {
  description = "GCP primary zone"
}

variable "gcp_admin_project_name" {
  description = "GCP admin project name"
}

variable "gcp_organization_id" {
  description = "GCP organization ID"
}

variable "gcp_billing_account_id" {
  description = "GCP billing ID"
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

variable "gcp_service_account_name" {
  description = "GCP service account name"
}

variable "gcp_ssh_ip_cidr" {
  description = "IP CIDR to allow SSH from"
}

variable "gcp_ssh_public_key" {
  description = "Public SSH key"
}

variable "gcp_authorized_cidr_range" {
  description = "IP CIDR range allowed to access the Kubernetes API"
}

variable "gcp_project_services" {
  description = "GCP project services"

  default = [
    "container.gcpapis.com",
    "compute.gcpapis.com",
    "iam.gcpapis.com",
    "cloudresourcemanager.gcpapis.com",
    "dns.gcpapis.com",
    "logging.gcpapis.com"
  ]
}

variable "gcp_service_account_roles" {
  description = "Roles to add to the service account"

  default = [
    "roles/storage.admin",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ]
}

variable "gcp_cidr_block" {
  description = "Main VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "gcp_bastion_cidr_block" {
  description = "CIDR block for bastions"
  default     = "192.168.1.0/24"
}

variable "gcp_subnetwork_secondary_ip_ranges" {
  description = "Secondary IP ranges to add to the subnetwork"

  default = [
    {
      range_name    = "services"
      ip_cidr_range = "10.1.0.0/20"
    },
    {
      range_name    = "pods"
      ip_cidr_range = "10.2.0.0/14"
    }
  ]
}

variable "gcp_master_ipv4_cidr_block" {
  description = "Kubernetes master ipv4 cidr block"
  default     = "10.0.0.0/28"
}

variable "gcp_kube_node_pool_min_node_count" {
  description = "Kubernetes node pool min node count"
  default     = 2
}

variable "gcp_kube_node_pool_max_node_count" {
  description = "Kubernetes node pool max node count"
  default     = 2
}

variable "gcp_node_machine_type" {
  description = "Kubernetes node machine type"
  default     = "n1-standard-2"
}
