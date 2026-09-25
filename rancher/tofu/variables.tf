variable "kubeconfig_path" {
  description = "Path to the kubeconfig used to connect to Kubernetes."
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubeconfig context for the Rancher installation."
  type        = string
  default     = "orbstack"
}

variable "rancher_hostname" {
  description = "Hostname used by the Rancher Ingress."
  type        = string
  default     = "rancher.k8s.orb.local"
}

variable "rancher_chart_version" {
  description = "Rancher Helm chart version."
  type        = string
  default     = "2.15.1"
}

variable "cert_manager_chart_version" {
  description = "cert-manager Helm chart version."
  type        = string
  default     = "v1.21.2"
}
