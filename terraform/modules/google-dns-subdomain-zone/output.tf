#
# Output.
#

output "name" {
  value       = google_dns_managed_zone.subdomain.name
  description = "Subdomain zone name"
}

