variable "kubeconfig_path" {
  description = "Path to the kubeconfig used to connect to Kubernetes."
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubeconfig context for the cluster bootstrap."
  type        = string
  default     = "orbstack"
}
