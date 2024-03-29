#
# Output.
#

output "endpoint" {
  value       = google_container_cluster.cluster.endpoint
  description = "Cluster endpoint"
}

output "ca_cert" {
  value       = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
  description = "Cluster CA cert"
}
