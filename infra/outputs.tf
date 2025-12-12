# --- Outputs ---
output "db_container_name" {
  description = "Database container name"
  value       = docker_container.db_container.name
}

output "app_access_url" {
  description = "Web application access URL"
  value       = "http://localhost:${docker_container.app_container.ports[0].external}"
}
