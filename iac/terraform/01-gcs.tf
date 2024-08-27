



# Development Bucket
resource "google_storage_bucket" "dev_bucket" {
  name         = format("%sricc-public-%s-development", var.terraform_prefix, var.app_name)
  location     = "EU"  # Public buckets can only be in multi-region locations
  storage_class = "standard"
  uniform_bucket_level_access = true
  force_destroy = true
  labels = {
    env = "prod"
    provisioned_with = "terraform"
    app = var.app_name
  }
}

# Production Bucket
resource "google_storage_bucket" "prod_bucket" {
  name         = format("%sricc-public-%s-production",  var.terraform_prefix, var.app_name)
  location     = "EU"  # Public buckets can only be in multi-region locations
  storage_class = "standard"
  uniform_bucket_level_access = true
  force_destroy = true
  labels = {
    env = "prod"
    provisioned_with = "terraform"
    app = var.app_name
  }
}

resource "google_storage_default_object_access_control" "public_rule_dev" {
  bucket = google_storage_bucket.dev_bucket.name
  role   = "READER"
  entity = "allUsers"
 }
resource "google_storage_default_object_access_control" "public_rule_prod" {
  bucket = google_storage_bucket.prod_bucket.name
  role   = "READER"
  entity = "allUsers"
 }

