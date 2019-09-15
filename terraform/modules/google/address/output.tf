#
# Output.
#

output "address" {
  value       = google_compute_address.address.address
  description = "Address"
}

