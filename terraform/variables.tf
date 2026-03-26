variable "cluster_name" {
  description = "Name of the local Kind cluster."
  type        = string
  default     = "homelab-cluster"
}

variable "k8s_version" {
  description = "Kubernetes node image version to ensure deterministic deployments."
  type        = string
  default     = "kindest/node:v1.29.0"
}

variable "ingress_nginx_chart_version" {
  description = "Pinned version of the ingress-nginx Helm chart."
  type        = string
  default     = "4.15.1"
}

variable "ingress_nginx_namespace" {
  description = "Kubernetes namespace for the NGINX Ingress Controller."
  type        = string
  default     = "ingress-nginx"
}

variable "echo_server_image" {
  description = "Container image for the ingress validation echo server."
  type        = string
  default     = "ealen/echo-server:0.9.2"
}
