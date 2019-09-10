#
# Terraform.
#

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "gcp_project" {
  source = "./modules/gcp-project"

  suffix                   = random_string.suffix.result
  gcp_region               = var.gcp_region
  gcp_primary_zone         = var.gcp_primary_zone
  gcp_project_name         = var.gcp_project_name
  gcp_organization_id      = var.gcp_organization_id
  gcp_billing_account_id   = var.gcp_billing_account_id
  gcp_project_services     = var.gcp_project_services
  gcp_admin_project_name   = var.gcp_admin_project_name
  gcp_service_account_name = var.gcp_service_account_name
}

module "gcp_dns_subdomain_zone" {
  source = "./modules/gcp-subdomain-dns-zone"

  suffix                 = random_string.suffix.result
  gcp_region             = var.gcp_region
  gcp_primary_zone       = var.gcp_primary_zone
  gcp_project_name       = module.gcp_project.project_id
  gcp_admin_project_name = var.gcp_admin_project_name
  gcp_dns_root_zone      = var.gcp_dns_root_zone
  gcp_dns_domain         = var.gcp_dns_domain
  gcp_dns_subdomain      = var.gcp_dns_subdomain
}

module "gcp_service_account" {
  source = "./modules/gcp-service-account"

  suffix                    = random_string.suffix.result
  gcp_region                = var.gcp_region
  gcp_primary_zone          = var.gcp_primary_zone
  gcp_project_name          = module.gcp_project.project_id
  gcp_service_account_name  = var.gcp_service_account_name
  gcp_service_account_roles = var.gcp_service_account_roles
}

module "gcp_vpc" {
  source = "./modules/gcp-vpc"

  suffix                             = random_string.suffix.result
  gcp_region                         = var.gcp_region
  gcp_primary_zone                   = var.gcp_primary_zone
  gcp_project_name                   = module.gcp_project.project_id
  gcp_ssh_ip_cidr                    = var.gcp_ssh_ip_cidr
  gcp_ssh_public_key                 = var.gcp_ssh_public_key
  gcp_cidr_block                     = var.gcp_cidr_block
  gcp_bastion_cidr_block             = var.gcp_bastion_cidr_block
  gcp_subnetwork_secondary_ip_ranges = var.gcp_subnetwork_secondary_ip_ranges
}

module "gcp_bastion" {
  source = "./modules/gcp-bastion"

  suffix                   = random_string.suffix.result
  gcp_region               = var.gcp_region
  gcp_primary_zone         = var.gcp_primary_zone
  gcp_project_name         = module.gcp_project.project_id
  gcp_vpc_subnetwork       = module.gcp_vpc.subnetwork
}

module "gcp_conatiner_cluster" {
  source = "./modules/gcp-container-cluster"

  suffix                             = random_string.suffix.result
  gcp_region                         = var.gcp_region
  gcp_primary_zone                   = var.gcp_primary_zone
  gcp_project_name                   = module.gcp_project.project_id
  gcp_vpc_network                    = module.gcp_vpc.network
  gcp_vpc_subnetwork                 = module.gcp_vpc.subnetwork
  gcp_subnetwork_secondary_ip_ranges = var.gcp_subnetwork_secondary_ip_ranges
  gcp_authorized_cidr_range          = var.gcp_authorized_cidr_range
  gcp_kube_node_pool_min_node_count  = var.gcp_kube_node_pool_min_node_count
  gcp_kube_node_pool_max_node_count  = var.gcp_kube_node_pool_max_node_count
  gcp_service_account                = module.gcp_service_account.service_account_unique_id
}


