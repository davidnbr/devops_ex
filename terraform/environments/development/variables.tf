variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name."
  type        = string
  default     = "devops-ex"
}

variable "image_tag" {
  description = "Container image tag to deploy."
  type        = string
  default     = "development"
}

variable "jwt_secret" {
  description = "JWT secret stored in Secrets Manager."
  type        = string
  sensitive   = true
}

variable "api_key" {
  description = "API key stored in Secrets Manager."
  type        = string
  sensitive   = true
}
