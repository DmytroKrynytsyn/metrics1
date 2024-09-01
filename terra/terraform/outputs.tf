
output "prometheus_instance_public_ip" {
  description = "Prometheus public IP"
  value       = aws_instance.prometheus.public_ip
}

output "grafana_instance_public_ip" {
  description = "Grafana public IP"
  value       = aws_instance.grafana.public_ip
}

output "node_instance_public_ip" {
  description = "Node public IP"
  value       = aws_instance.node.public_ip
}
