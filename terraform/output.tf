#
# Output.
#

output "google_services_address" {
  value       = module.google_address.address
  description = "Google services address"
}

output "istio_kiali_password" {
  value       = module.istio.kiali_password
  description = "Kiali password"
}
