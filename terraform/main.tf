terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
  }
}

provider "google-beta" {
  user_project_override = true
}

provider "google-beta" {
  alias = "no_user_project_override"
  user_project_override = false
}

resource "random_id" "server" {
  byte_length = 2
}

resource "google_project" "default" {
  provider = google-beta

  project_id      = "flutter-cookbook-${random_id.server.hex}"
  name            = "Flutter cookbook"
  billing_account = var.billing_account

  labels = {
    "firebase" = "enabled"
  }
}

resource "google_project_service" "default" {
  provider = google-beta.no_user_project_override
  project  = google_project.default.project_id
  for_each = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    "serviceusage.googleapis.com",
  ])
  service = each.key

  disable_on_destroy = false
}

resource "google_firebase_project" "flutter_cookbook" {
  provider = google-beta
  project  = google_project.default.project_id

  depends_on = [
    google_project_service.default,
  ]
}
