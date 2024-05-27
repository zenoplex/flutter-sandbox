resource "google_firestore_database" "database" {
  project     = google_project.default.project_id
  name        = "(default)"
  location_id = "asia-northeast1"
  type        = "FIRESTORE_NATIVE"
}

# TODO: Add ruleset_release resource
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
