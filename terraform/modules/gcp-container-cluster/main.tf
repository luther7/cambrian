#
# Container.
#

provider "google" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

provider "google-beta" {
  region = var.gcp_region
  zone   = var.gcp_primary_zone
}

data "google_container_engine_versions" "location" {
  project  = var.gcp_project_name
  location = var.gcp_region
}

resource "google_container_cluster" "cluster" {
  name                     = "cluster-${var.suffix}"
  project                  = var.gcp_project_name
  location                 = var.gcp_region
  network                  = var.gcp_vpc_network
  subnetwork               = var.gcp_vpc_subnetwork
  min_master_version       = data.google_container_engine_versions.location.latest_master_version
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    preemptible     = var.gcp_preemptable_kube_cluster
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.gcp_subnetwork_secondary_ip_ranges[0].range_name
    services_secondary_range_name = var.gcp_subnetwork_secondary_ip_ranges[1].range_name
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = var.gcp_kube_issue_client_certificate
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = var.gcp_authorized_cidr_range
    }
  }

  private_cluster_config {
    enable_private_endpoint = var.gcp_kube_enable_private_endpoint
    enable_private_nodes    = var.gcp_kube_enable_private_nodes
    master_ipv4_cidr_block  = var.gcp_master_ipv4_cidr_block
  }
}

resource "google_container_node_pool" "cluster_node_pool" {
  name       = "node-pool-${var.suffix}"
  project    = var.gcp_project_name
  cluster    = google_container_cluster.cluster.name
  location   = var.gcp_region
  node_count = var.gcp_kube_node_pool_min_node_count

  node_config {
    service_account = var.gcp_service_account
    machine_type    = var.gcp_node_machine_type
    preemptible     = var.gcp_preemptable_kube_nodes
  }

  management {
    auto_repair  = var.gcp_kube_node_pool_auto_repair
    auto_upgrade = var.gcp_kube_node_pool_auto_upgrade
  }

  autoscaling {
    min_node_count = var.gcp_kube_node_pool_min_node_count
    max_node_count = var.gcp_kube_node_pool_max_node_count
  }

  lifecycle {
    ignore_changes = [node_count]
  }
}
