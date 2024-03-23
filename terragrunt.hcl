terraform {
  source = "../modules/s3_bucket"
}

# Add more configurations for lambda_function module

include {
  path = find_in_parent_folders()
}
