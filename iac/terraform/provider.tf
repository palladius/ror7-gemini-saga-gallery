# Configure the Google Cloud Provider with project ID from environment variable
# provider "google" {
#   project = var.project_id
#   region  = var.gcp_region
# }
provider "google-beta" {
  project = "${var.project}"
  region  = var.gcp_region


}
