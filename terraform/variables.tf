variable "cluster_name" {
  description = "Name of the local Kind cluster"
  type        = string
  default     = "homelab-cluster"
}

variable "k8s_version" {
  description = "Kubernetes node image version to ensure deterministic deployments."
  type        = string
  default     = "kindest/node:v1.29.0" 
}
