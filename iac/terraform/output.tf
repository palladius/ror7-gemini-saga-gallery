
# output "version" {
#   value = var.app_version
# }

# "rails-service-account-from-file"
# output "secret_perma_url" {
#   value = "${google_secret_manager_secret.rails-envrc.secret_id}"
# }
output "project_id" {
  value = "${google_secret_manager_secret.rails-envrc.project}"
}
# https://console.cloud.google.com/security/secret-manager/secret/tf-saga-gallery-envrc/versions?e=-13802955&mods=logs_tg_staging&project=ror-goldie
output "secret_envrc_pantheon_url" {
    value = "https://console.cloud.google.com/security/secret-manager/secret/${google_secret_manager_secret.rails-envrc.secret_id}/versions?project=${google_secret_manager_secret.rails-envrc.project}"
}

# https://console.cloud.google.com/security/secret-manager?referrer=search&e=-13802955&mods=logs_tg_staging&project=ror-goldie
