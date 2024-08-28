
resource "google_artifact_registry_repository" "my_repo" {
  #name        = format("%s%s", var.terraform_prefix, var.my_repo_name)
  repository_id = format("%s%s", var.terraform_prefix, var.my_repo_name)
  location    = "${var.gcp_region}"
  project = var.project_id # TODO(drebes): is there a way to automatically ADD the project in all my stanzas?
  format      = "DOCKER"
  description = "[TF] Repo for RoR Gemini Saga Gallery super-duper docker repo"
  labels      = {
    app-type = "rails"
    #app      = "rails"
    env      = "prod"
    provisioned_with = "terraform"
    app = var.app_name
  }

    provisioner "local-exec" {
        command = "./post-ar-creation-hook.sh"
        #command = "echo ${var.gcp_region} >> ZZZ_gcp_region.txt"
        environment = {
            GCP_REGION = var.gcp_region
            BAR = 1
            BAZ = "true"
        }
    }
}
