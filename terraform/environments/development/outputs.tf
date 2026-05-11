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

output "ecs_task_definition_arn" {
  description = "ECS task definition ARN."
  value       = module.app.task_definition_arn
}

output "load_balancer_dns_name" {
  description = "Development ALB DNS name."
  value       = module.app.load_balancer_dns_name
}

output "api_gateway_endpoint" {
  description = "Development API Gateway endpoint."
  value       = module.app.api_gateway_endpoint
}
