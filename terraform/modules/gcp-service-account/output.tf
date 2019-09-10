#
# Output.
#

output "service_account_id" {
  value       = google_service_account.service_account.account_id
  description = "Service account ID"
}

output "service_account_unique_id" {
  value       = google_service_account.service_account.unique_id
  description = "Service account ID"
}

