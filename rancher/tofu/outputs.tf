output "rancher_url" {
  description = "URL for the Rancher server."
  value       = "https://${var.rancher_hostname}"
}
