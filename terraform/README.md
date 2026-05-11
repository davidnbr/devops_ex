# Terraform Infrastructure

This directory contains Terraform Infrastructure that will be deployed for the different environments. Uses AWS.

Includes load balancing with ALB, ECS with autoscaling to automatically deploy the containerized environments.
Secrets are managed with Secrets Manager in AWS.

## Layout

- `environments/production`: ECS Fargate service behind API Gateway and an Application Load Balancer.
- `environments/staging`: ECS Fargate service behind API Gateway and an Application Load Balancer.
- `environments/development`: ECS Fargate service behind API Gateway and an Application Load Balancer.
- `modules/ecr`: reusable ECR repository.
- `modules/network`: reusable VPC, public subnet and internet gateway.
- `modules/ecs-service`: reusable ECS/Fargate service, API Gateway, ALB and autoscaling.

## Example Commands

```bash
cd terraform/environments/staging
terraform init
terraform plan -var-file=terraform.tfvars
```

Use `terraform.tfvars.example` as a template. Do not commit real secrets.
