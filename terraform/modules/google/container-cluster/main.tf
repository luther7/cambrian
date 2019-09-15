#
# Container.
#

provider "google" {
  region = var.google_region
  zone   = var.google_primary_zone
}

provider "google-beta" {
  region = var.google_region
  zone   = var.google_primary_zone
}

resource "google_project_service" "service" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com"
  ])

  service                    = each.value
  project                    = var.google_project_name
  disable_dependent_services = true
}

data "google_container_engine_versions" "location" {
  project  = var.google_project_name
  location = var.google_region

  depends_on = [google_project_service.service]
}

resource "google_container_cluster" "cluster" {
  name                     = "cluster-${var.suffix}"
  project                  = var.google_project_name
  location                 = var.google_region
  network                  = var.google_network
  subnetwork               = var.google_subnetwork
  min_master_version       = data.google_container_engine_versions.location.latest_master_version
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    preemptible = var.google_preemptable_kube_cluster
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.google_cluster_secondary_range_name
    services_secondary_range_name = var.google_services_secondary_range_name
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = var.google_kube_issue_client_certificate
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.google_kube_api_ip_cidr_ranges

      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  private_cluster_config {
    enable_private_endpoint = var.google_kube_enable_private_endpoint
    enable_private_nodes    = var.google_kube_enable_private_nodes
    master_ipv4_cidr_block  = var.google_kube_master_cidr_range
  }

  lifecycle {
    ignore_changes = [min_master_version]
  }

  depends_on = [google_project_service.service]
}

resource "google_container_node_pool" "cluster_node_pool" {
  name       = "node-pool-${var.suffix}"
  project    = var.google_project_name
  cluster    = google_container_cluster.cluster.name
  location   = var.google_region
  node_count = var.google_kube_node_pool_min_count

  node_config {
    service_account = var.google_service_account
    machine_type    = var.google_kube_node_machine_type
    preemptible     = var.google_preemptable_kube_nodes
  }

  management {
    auto_repair  = var.google_kube_node_pool_auto_repair
    auto_upgrade = var.google_kube_node_pool_auto_upgrade
  }

  autoscaling {
    min_node_count = var.google_kube_node_pool_min_count
    max_node_count = var.google_kube_node_pool_max_count
  }

  lifecycle {
    ignore_changes = [node_count]
  }

  depends_on = [google_project_service.service]
}
