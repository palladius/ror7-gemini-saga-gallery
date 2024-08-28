variable "app_name" {
  type = string
  default = "saga-gallery"
}

variable "project_id" {
  type = string
  default = "ror-goldie"
}

variable "gcp_region" {
  type = string
  default = "europe-west1"
}
variable "terraform_prefix" {
  type = string
  default = "tf-"
}

variable "bucket_names" {
  type = list(string)
  default = [
    "%sricc-public-%s-development",
    "%sricc-public-%s-production"
  ]
}

variable "sa_key_path" {
  type = string
  description = "From ENVRC: MY_REPO_NAME. Used to build the AR/GCR path."
  default = "../../private/ror-goldie-scooby-n-sagallery.json"
}
variable "envrc_path" {
  type = string
  description = "Local .envrc with all my juicy secrets (RAILS_MASTER_KEY, ..)"
  default = "../../_env_gaic.sh" # created through GAIC
}
variable "my_repo_name" {
  type = string
  description = "From ENVRC: MY_REPO_NAME. Used to build the AR/GCR path."
  default = "ror7-gemini-saga-gallery"
}
