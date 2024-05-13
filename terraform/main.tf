terraform {
  backend "gcs" {
    bucket = "0c12da7150fa35dd-bucket-tfstate"
    prefix = "terraform.tfstate"
  }
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
  alias                 = "no_user_project_override"
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
    "storage.googleapis.com"
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

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "tfstate" {
  provider      = google-beta
  project       = google_project.default.project_id
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  location      = "ASIA"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

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
