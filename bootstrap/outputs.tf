output "ingress_class" {
  description = "IngressClass installed for the sample manifests."
  value       = "traefik"
}

output "verification_command" {
  description = "Command to verify the installed ingress controller."
  value       = "kubectl --context ${var.kube_context} get ingressclass traefik"
}
