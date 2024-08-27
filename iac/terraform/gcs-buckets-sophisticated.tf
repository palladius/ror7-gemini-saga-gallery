



# # Development Bucket
# resource "google_storage_bucket" "dev_bucket" {
#   name         = format("%sricc-public-%s-development", var.terraform_prefix, var.app_name)
#   location     = "EU"  # Public buckets can only be in multi-region locations
#   storage_class = "standard"
#   force_destroy = true
# }

# # Production Bucket
# resource "google_storage_bucket" "prod_bucket" {
#   name         = format("%sricc-public-%s-production",  var.terraform_prefix, var.app_name)
#   location     = "EU"  # Public buckets can only be in multi-region locations
#   storage_class = "standard"
#   force_destroy = true
# }

# resource "google_storage_default_object_access_control" "public_rule" {
#   bucket = google_storage_bucket.dev_bucket.name
#   role   = "READER"
#   entity = "allUsers"
#  }
# resource "google_storage_bucket" "bucketz" {
#   for_each = {
#     for name in var.bucket_names : name => name
#   }
#   name         = format(each.key, var.terraform_prefix, var.app_name)
#   location     = "EU"  # Public buckets can only be in multi-region locations
#   storage_class = "standard"
#   force_destroy = true
# }

# resource "google_storage_default_object_access_control" "public_rulez" {
#   for_each = {
#     for name in var.bucket_names : name => name
#   }
#   bucket = each.key.name # google_storage_bucket.dev_bucket.name
#   role   = "READER"
#   entity = "allUsers"
#  }
# resource "google_storage_default_object_access_control" "public_rule" {
#   for_each = {
#     for name in var.bucket_names : name => name
#   }
#   bucket = format(each.value, var.terraform_prefix, var.app_name)
#   role   = "READER"
#   entity = "allUsers"

#   # Define dependency on the corresponding bucket
# #   depends_on = [
# #     google_storage_bucket.bucket[each.key]
# #   ]
# # Ask Roberto
#   depends_on = [
#     null_resource.create_buckets
#   ]
# }
