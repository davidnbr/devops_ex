output "ecr_repository_url" {
  description = "ECR repository URL for image pushes."
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.app.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name."
  value       = module.app.service_name
}

output "load_balancer_dns_name" {
  description = "Production ALB DNS name."
  value       = module.app.load_balancer_dns_name
}
