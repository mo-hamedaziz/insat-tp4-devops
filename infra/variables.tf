# --- Variables d'Application ---
variable "app_port_external" {
  description = "Port externe pour accéder à l'application web (mappé au port 80 interne)."
  type        = number
  default     = 8080
}