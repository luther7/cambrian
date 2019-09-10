#
# Output.
#

output "subdomain_zone_name" {
  value       = google_dns_managed_zone.subdomain.name
  description = "Project id"
}

