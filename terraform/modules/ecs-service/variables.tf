variable "name" {
  description = "Name prefix for ECS resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the ALB and ECS tasks."
  type        = list(string)
}

variable "container_image" {
  description = "Container image URI to deploy."
  type        = string
}

variable "container_port" {
  description = "Container port exposed by the app."
  type        = number
  default     = 8000
}

variable "desired_count" {
  description = "Number of ECS tasks."
  type        = number
  default     = 2
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 512
}

variable "jwt_secret_arn" {
  description = "Secrets Manager ARN for JWT_SECRET."
  type        = string
}

variable "api_key_arn" {
  description = "Secrets Manager ARN for API_KEY."
  type        = string
}

variable "tags" {
  description = "Tags applied to all supported resources."
  type        = map(string)
  default     = {}
}
