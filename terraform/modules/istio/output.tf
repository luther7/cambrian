#
# Output.
#

output "kiali_password" {
  value       = random_string.kiali_password.result
  description = "Kiali password"
}
