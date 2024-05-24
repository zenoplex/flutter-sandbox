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

locals {
  collection  = "poll"
  document_id = "document_id"
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

resource "google_firestore_database" "database" {
  project     = google_project.default.project_id
  name        = "(default)"
  location_id = "asia-northeast1"
  type        = "FIRESTORE_NATIVE"
}

resource "google_firebaserules_ruleset" "firestore" {
  project = google_project.default.project_id
  source {
    files {
      content = templatefile("${path.module}/templates/firebaserules_ruleset_firestore_content.tftpl", { collection : local.collection, document_id : local.document_id })
      name    = "firestore.rules"
    }
  }
}

resource "google_firestore_document" "document_id" {
  project     = google_project.default.project_id
  database    = google_firestore_database.database.name
  collection  = local.collection
  document_id = local.document_id
  # NOTE: Could not use data "template_file" "document" on M1 mac
  fields = templatefile("${path.module}/templates/document_id.tftpl", {})

  lifecycle {
    ignore_changes = [
      # TODO: How can I ignore changes on specific fields using templatefile directive?
      fields,
    ]
  }
}

resource "google_storage_bucket" "firebase_storage" {
  provider      = google-beta
  project       = google_project.default.project_id
  name          = "${random_id.bucket_prefix.hex}-bucket-firebase-storage"
  location      = "asia-northeast1"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

resource "google_firebase_storage_bucket" "default" {
  provider  = google-beta
  project   = google_project.default.project_id
  bucket_id = google_storage_bucket.firebase_storage.id
}
