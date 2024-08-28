
# sa_key_path

## EXAMPLE
# Created here: https://console.cloud.google.com/security/secret-manager?e=-13802955&mods=logs_tg_staging&project=ror-goldie
resource "google_secret_manager_secret" "rails-service-account-base64" {
  secret_id = "${var.terraform_prefix}${var.app_name}-gcs-writer-service-account-base64"
  project = var.project_id

  labels = {
    app_name = var.app_name
    app_type = "rails"
    app = var.app_name
    provisioned_with = "terraform"
  }
  annotations = {
    used_for = var.app_name
    description1 = "[TF] Since a Secret doesnt allow any description, this is me telling you its a Secret for Rails"
    description2 = "to write/read to GCS principally, and who knows, maybe then to also use Gemini."
  }
  replication {
    auto {}
  }
}
resource "google_secret_manager_secret_version" "rails-service-account-base64-from-file" {
  secret = google_secret_manager_secret.rails-service-account-base64.id

  is_secret_data_base64 = true
  secret_data = filebase64(var.sa_key_path)
}

