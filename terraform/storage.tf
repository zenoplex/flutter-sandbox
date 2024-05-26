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

resource "google_firebaserules_ruleset" "storage" {
  provider = google-beta
  project  = google_project.default.project_id
  source {
    files {
      content = templatefile("${path.module}/templates/firebaserules_ruleset_storage_content.tftpl", {})
      name    = "storage.rules"
    }
  }
  depends_on = [google_firebase_storage_bucket.default]
}

resource "google_firebaserules_release" "storage" {
  provider     = google-beta
  project      = google_project.default.project_id
  name         = "firebase.storage/${google_storage_bucket.firebase_storage.name}"
  ruleset_name = "projects/${google_project.default.project_id}/rulesets/${google_firebaserules_ruleset.storage.name}"

  lifecycle {
    replace_triggered_by = [
      google_firebaserules_ruleset.storage
    ]
  }
}

resource "google_firebase_storage_bucket" "default" {
  provider  = google-beta
  project   = google_project.default.project_id
  bucket_id = google_storage_bucket.firebase_storage.id
}
