variable "name" {
  description = "ECR repository name."
  type        = string
}

variable "tags" {
  description = "Tags applied to all supported resources."
  type        = map(string)
  default     = {}
}
