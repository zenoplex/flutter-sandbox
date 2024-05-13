
variable "billing_account" {
  description = "Billing account Id"
  type        = string
  sensitive   = true
}

variable "google_client_id" {
  description = "Google client Id"
  type        = string
  sensitive   = true
}

variable "google_client_secret" {
  description = "Google client secret"
  type        = string
  sensitive   = true
}
