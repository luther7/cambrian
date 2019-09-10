#
# Output.
#

output "network" {
  value       = google_compute_network.vpc.self_link
  description = "VPC network"
}

output "subnetwork" {
  value       = google_compute_subnetwork.subnetwork.self_link
  description = "VPC subnetwork"
}
