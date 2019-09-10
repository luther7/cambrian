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

variable "gcp_vpc_network" {
  description = "GCP VPC network"
}

variable "gcp_vpc_subnetwork" {
  description = "GCP VPC subnetwork"
}

variable "gcp_preemptable_kube_cluster" {
  description = "Preemptable Kubernetes cluster"
  default     = true
}

variable "gcp_subnetwork_secondary_ip_ranges" {
  description = "Secondary ranges for cluster"
}

variable "gcp_authorized_cidr_range" {
  description = "IP CIDR range allowed to access the Kubernetes API"
}

variable "gcp_kube_enable_private_endpoint" {
  description = "Kubernetes enable private endpoint"
  default     = true
}

variable "gcp_kube_enable_private_nodes" {
  description = "Kubernetes enable private nodes"
  default     = true
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

variable "gcp_service_account" {
  description = "GCP service account"
}

variable "gcp_node_machine_type" {
  description = "Kubernetes node machine type"
  default     = "n1-standard-2"
}

variable "gcp_preemptable_kube_nodes" {
  description = "Enable preemptable kube nodes"
  default     = true
}

variable "gcp_kube_node_pool_auto_repair" {
  description = "Enable Kube node pool auto repair"
  default     = true
}

variable "gcp_kube_node_pool_auto_upgrade" {
  description = "Enable Kubernetes node pool auto upgrade"
  default     = true
}

variable "gcp_kube_issue_client_certificate" {
  description = "Whether to issue a client certificate"
  default     = false
}
