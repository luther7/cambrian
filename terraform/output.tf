#
# Output.
#

output "google_services_address" {
  value       = module.google_address.address
  description = "Google services address"
}
