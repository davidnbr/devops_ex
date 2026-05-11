output "cluster_name" {
  description = "ECS cluster name."
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "ECS service name."
  value       = aws_ecs_service.this.name
}

output "load_balancer_dns_name" {
  description = "Application Load Balancer DNS name."
  value       = aws_lb.this.dns_name
}
