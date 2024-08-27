



# Development Bucket
resource "google_storage_bucket" "dev_bucket" {
  name         = format("%sricc-public-%s-development", var.terraform_prefix, var.app_name)
  location     = "EU"  # Public buckets can only be in multi-region locations
  storage_class = "standard"
  force_destroy = true
}

# Production Bucket
resource "google_storage_bucket" "prod_bucket" {
  name         = format("%sricc-public-%s-production",  var.terraform_prefix, var.app_name)
  location     = "EU"  # Public buckets can only be in multi-region locations
  storage_class = "standard"
  force_destroy = true
}

resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.dev_bucket.name
  role   = "READER"
  entity = "allUsers"
 }

