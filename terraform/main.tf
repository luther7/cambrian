#
# Terraform.
#

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "google_project" {
  source = "./modules/google-project"

  suffix                      = random_string.suffix.result
  google_region               = var.google_region
  google_primary_zone         = var.google_primary_zone
  google_project_name         = var.google_project_name
  google_admin_project_name   = var.google_admin_project_name
  google_organization_id      = var.google_organization_id
  google_billing_account_id   = var.google_billing_account_id
  google_service_account_name = var.google_service_account_name
  google_ssh_public_key       = var.google_ssh_public_key
}

module "google_dns_subdomain_zone" {
  source = "./modules/google-dns-subdomain-zone"

  suffix                    = random_string.suffix.result
  google_region             = var.google_region
  google_primary_zone       = var.google_primary_zone
  google_project_name       = module.google_project.project_id
  google_admin_project_name = var.google_admin_project_name
  google_dns_root_zone      = var.google_dns_root_zone
  google_dns_domain         = var.google_dns_domain
  google_dns_subdomain      = var.google_dns_subdomain
}

module "google_service_account" {
  source = "./modules/google-service-account"

  suffix                       = random_string.suffix.result
  google_region                = var.google_region
  google_primary_zone          = var.google_primary_zone
  google_project_name          = module.google_project.project_id
  google_service_account_name  = var.google_service_account_name
  google_service_account_roles = var.google_service_account_roles
}

module "google_network" {
  source = "./modules/google-network"

  suffix                    = random_string.suffix.result
  google_region             = var.google_region
  google_primary_zone       = var.google_primary_zone
  google_project_name       = module.google_project.project_id
  google_ssh_ip_cidr_ranges = var.google_ssh_ip_cidr_ranges
  google_cidr_range         = var.google_cidr_range

  google_subnetwork_secondary_ip_cidr_ranges = concat(
    [
      {
        range_name    = "bastion",
        ip_cidr_range = var.google_bastion_cidr_range
      }
    ],
    var.google_subnetwork_secondary_ip_cidr_ranges
  )
}

module "google_bastion" {
  source = "./modules/google-bastion"

  suffix              = random_string.suffix.result
  google_region       = var.google_region
  google_primary_zone = var.google_primary_zone
  google_project_name = module.google_project.project_id
  google_subnetwork   = module.google_network.subnetwork
}

module "google_container_cluster" {
  source = "./modules/google-container-cluster"

  suffix                               = random_string.suffix.result
  google_region                        = var.google_region
  google_primary_zone                  = var.google_primary_zone
  google_project_name                  = module.google_project.project_id
  google_network                       = module.google_network.network
  google_subnetwork                    = module.google_network.subnetwork
  google_cluster_secondary_range_name  = var.google_subnetwork_secondary_ip_cidr_ranges[0].range_name
  google_services_secondary_range_name = var.google_subnetwork_secondary_ip_cidr_ranges[1].range_name
  google_kube_master_cidr_range        = var.google_kube_master_cidr_range
  google_kube_api_ip_cidr_ranges       = var.google_kube_api_ip_cidr_ranges
  google_kube_node_pool_min_count      = var.google_kube_node_pool_min_count
  google_kube_node_pool_max_count      = var.google_kube_node_pool_max_count
  google_service_account               = module.google_service_account.service_account_unique_id
}

module "helm" {
  source = "./modules/helm"

  kube_cluster_endpoint = module.google_container_cluster.endpoint
  kube_cluster_ca_cert  = module.google_container_cluster.ca_cert
}




