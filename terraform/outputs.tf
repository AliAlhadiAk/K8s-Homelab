output "cluster_endpoint" {
  description = "the kube api server endpoint"
  value       = kind_cluster.default.endpoint
}
