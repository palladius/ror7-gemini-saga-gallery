resource "google_cloud_run_v2_service" "helloworld" {
  name     = "${var.terraform_prefix}${var.app_name}-hello-world-deleteme"
  location = var.gcp_region # "us-central1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"
  project = var.project_id

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}


# Pointing to LATEST - might not be the best
resource "google_cloud_run_v2_service" "rails_app_dev_to_latest" {
  name     = "${var.terraform_prefix}${var.app_name}-rails-dev"
  location = var.gcp_region # "us-central1"
  deletion_protection = false
  project = var.project_id
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    # scaling {
    #   max_instance_count = 2
    # }
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"

      env {
        name = "RAILS_ENV"
        value = "development"
      }
      env {
        name = "MESSAGGIO_OCCASIONALE"
        value = "[TF] Created with TF, still WIP. Secret should come FOR FREE as a given from TF!!"
      }
      # env {
      #   name = "ServiceAccount"
      #   value_source {
      #     secret_key_ref {
      #       secret = google_secret_manager_secret.secret.rails-service-account
      #       version = "1"
      #     }
      #   }
      # }
      #depends_on = [google_secret_manager_secret_version.rails-service-account]
      #depends_on = [google_secret_manager_secret.rails-service-account.id]


      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }
  }
}




