# INSAT TP4 DevOps

A DevOps project demonstrating infrastructure as code (IaC) using Terraform and Docker.

## Project Structure

- `web-app/` - Nginx-based web application with Docker configuration
- `infra/` - Terraform infrastructure definitions for Docker containers

## Components

- **PostgreSQL Database**: Containerized PostgreSQL instance
- **Nginx Web App**: Alpine-based Nginx web server serving static content

## Technologies

- Terraform (+Docker provider)
- Docker
- Nginx
- PostgreSQL

## Quick Start

1. Navigate to infrastructure directory:
   ```bash
   cd infra
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Apply infrastructure:
   ```bash
   terraform apply
   ```

4. Access the web application at `http://localhost:8080`

## Cleanup

```bash
terraform destroy
```