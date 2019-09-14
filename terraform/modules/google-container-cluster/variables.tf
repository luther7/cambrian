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

variable "google_network" {
  description = "Network"
}

variable "google_subnetwork" {
  description = "Subnetwork"
}

variable "google_preemptable_kube_cluster" {
  description = "Preemptable Kubernetes cluster"
  default     = true
}

variable "google_subnetwork_secondary_ip_cidr_blocks" {
  description = "Secondary IP CIDR blocks to add to the cluster"
}

variable "google_kube_api_ip_cidr" {
  description = "IP CIDR range allowed to access the Kubernetes API"
}

variable "google_kube_enable_private_endpoint" {
  description = "Kubernetes enable private endpoint"
  default     = false
}

variable "google_kube_enable_private_nodes" {
  description = "Kubernetes enable private nodes"
  default     = true
}

variable "google_kube_master_cidr_block" {
  description = "Kubernetes master CIDR block"
  default     = "10.20.0.0/28"
}

variable "google_kube_node_pool_min_count" {
  description = "Kubernetes node pool min count"
  default     = 2
}

variable "google_kube_node_pool_max_count" {
  description = "Kubernetes node pool max count"
  default     = 2
}

variable "google_service_account" {
  description = "Service account"
}

variable "google_kube_node_machine_type" {
  description = "Kubernetes node machine type"
  default     = "n1-standard-2"
}

variable "google_preemptable_kube_nodes" {
  description = "Enable preemptable kube nodes"
  default     = true
}

variable "google_kube_node_pool_auto_repair" {
  description = "Enable Kube node pool auto repair"
  default     = true
}

variable "google_kube_node_pool_auto_upgrade" {
  description = "Enable Kubernetes node pool auto upgrade"
  default     = true
}

variable "google_kube_issue_client_certificate" {
  description = "Whether to issue a client certificate"
  default     = false
}
