
# sa_key_path

## EXAMPLE
# Created here: https://console.cloud.google.com/security/secret-manager?e=-13802955&mods=logs_tg_staging&project=ror-goldie
resource "google_secret_manager_secret" "rails-service-account" {
  secret_id = "${var.terraform_prefix}${var.app_name}-gcs-writer-service-account"
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
    user_managed {
      replicas {
        location = "us-central1" # risky
      }
      replicas {
        location = var.gcp_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "rails-service-account-from-file" {
  secret = google_secret_manager_secret.rails-service-account.id

  #secret_data = "my-TF-secret-data"
  is_secret_data_base64 = false
  #secret_data = filebase64(var.sa_key_path)
  secret_data = file(var.sa_key_path)
}




resource "google_secret_manager_secret" "rails-envrc" {
  secret_id = "${var.terraform_prefix}${var.app_name}-envrc"
  project = var.project_id

  labels = {
    app_name = var.app_name
    app_type = "rails"
    app = var.app_name
    provisioned_with = "terraform"
  }
  annotations = {
    used_for = var.app_name
    description1 = "[TF] This contains a local ENVRC for rails build/deploy script to then pull from SM"
    description2 = "into the docker container"
  }
  replication {
    user_managed {
      replicas {
        location = "us-central1" # risky
      }
      replicas {
        location = var.gcp_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "rails-envrc-from-file" {
  secret = google_secret_manager_secret.rails-envrc.id

  is_secret_data_base64 = false
  secret_data = file(var.envrc_path)
}

