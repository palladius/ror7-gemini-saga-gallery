



# Development Bucket
resource "google_storage_bucket" "dev_bucket" {
  name         = format("%sricc-public-%s-development", var.terraform_prefix, var.app_name)
  location     = "EU"  # Public buckets can only be in multi-region locations
  project = var.project_id
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
  project = var.project_id
  storage_class = "standard"
  uniform_bucket_level_access = true
  force_destroy = true
  labels = {
    env = "prod"
    provisioned_with = "terraform"
    app = var.app_name
  }
}

# │ Error: Error creating DefaultObjectAccessControl: googleapi: Error 400: Cannot use ACL API to update bucket policy when uniform bucket-level access is enabled. Read more at https://cloud.google.com/storage/docs/uniform-bucket-level-access, invalid
# resource "google_storage_default_object_access_control" "public_rule_dev" {
#   bucket = google_storage_bucket.dev_bucket.name
#   role   = "READER"
#   entity = "allUsers"
#  }
# resource "google_storage_default_object_access_control" "public_rule_prod" {
#   bucket = google_storage_bucket.prod_bucket.name
#   role   = "READER"
#   entity = "allUsers"
#  }

# https://stackoverflow.com/questions/75373877/how-to-create-public-google-bucket-with-uniform-bucket-level-access-enabled
resource "google_storage_bucket_iam_member" "member_dev" {
  bucket = google_storage_bucket.dev_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
resource "google_storage_bucket_iam_member" "member_prod" {
  bucket = google_storage_bucket.prod_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
