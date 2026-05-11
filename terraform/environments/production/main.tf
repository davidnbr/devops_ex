data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  environment = "production"
  name        = "${var.project_name}-${local.environment}"

  tags = {
    Project     = var.project_name
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

module "network" {
  source = "../../modules/network"

  name               = local.name
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]
  vpc_cidr = "10.20.0.0/16"
  tags     = local.tags
}

module "ecr" {
  source = "../../modules/ecr"

  name = local.name
  tags = local.tags
}

resource "aws_secretsmanager_secret" "jwt_secret" {
  name = "${local.name}/jwt-secret"
}

resource "aws_secretsmanager_secret_version" "jwt_secret" {
  secret_id     = aws_secretsmanager_secret.jwt_secret.id
  secret_string = sensitive(var.jwt_secret)
}

resource "aws_secretsmanager_secret" "api_key" {
  name = "${local.name}/api-key"
}

resource "aws_secretsmanager_secret_version" "api_key" {
  secret_id     = aws_secretsmanager_secret.api_key.id
  secret_string = sensitive(var.api_key)
}

module "app" {
  source = "../../modules/ecs-service"

  name            = local.name
  vpc_id          = module.network.vpc_id
  subnet_ids      = module.network.public_subnet_ids
  container_image = "${module.ecr.repository_url}:${var.image_tag}"
  desired_count   = 2
  jwt_secret_arn  = aws_secretsmanager_secret.jwt_secret.arn
  api_key_arn     = aws_secretsmanager_secret.api_key.arn
  tags            = local.tags
}
