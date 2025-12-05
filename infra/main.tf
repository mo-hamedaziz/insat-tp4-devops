# --- Terraform and Provider Configuration ---
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1" # Specifies the Docker provider
    }
  }
}

provider "docker" {}

# --- 1. Resource: PostgreSQL Database ---
# Downloads the PostgreSQL image from Docker Hub
resource "docker_image" "postgres_image" {
  name         = "postgres:latest"
  keep_locally = true
}

# Creates and configures the PostgreSQL container
resource "docker_container" "db_container" {
  name  = "tp-db-postgres"
  image = docker_image.postgres_image.image_id

  ports {
    internal = 5432
    external = 5432 # Mapping to default port 5432
  }

  # Database configuration via environment variables
  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]
}

# --- 2. Resource: Nginx Web Application ---
# Builds the application image from the local Dockerfile
resource "docker_image" "app_image" {
  name = "tp-web-app:latest"

  build {
    context    = ".." # Parent directory where the Dockerfile is located
    dockerfile = "./Dockerfile"
    no_cache   = true
  }
}

# Creates the web application container
resource "docker_container" "app_container" {
  name  = "tp-app-web"
  image = docker_image.app_image.image_id

  # Explicit dependency: the DB must be ready before the Application
  depends_on = [
    docker_container.db_container
  ]

  # Mapping internal port 80 to external port defined in variables.tf (default 8080)
  ports {
    internal = 80
    external = var.app_port_external
  }
}
