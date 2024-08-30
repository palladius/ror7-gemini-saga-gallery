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

# From
variable "APP_VERSION" {
  type = string
  description = "Should be the latest value from ../../VERSION populated in TFVARS. From ENV, hence upcased."
  # NO DEFAULT! Needs to fail if not given.
}

# TODO risolvi questo
# variable "app_version" {
#   type = string
#   description = "TF complains with ricc: │ The root module does not declare a variable named app_version but a value was found in file terraform.tfvars. If you meant to use this value, add a variable block to the configuration."
# }
