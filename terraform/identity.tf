resource "google_identity_platform_config" "default" {
  provider = google-beta
  project  = google_project.default.project_id

  depends_on = [
    google_project_service.default,
  ]

  sign_in {
    email {
      enabled           = true
      password_required = false
    }
  }
}

resource "google_identity_platform_default_supported_idp_config" "idp_config" {
  provider = google-beta
  project  = google_project.default.project_id

  enabled       = true
  idp_id        = "google.com"
  client_id     = var.google_client_id
  client_secret = var.google_client_secret
}
