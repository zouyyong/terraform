region                               = "your_aws_region"
bucket_name                          = "your_bucket_name"
logging_bucket                       = "your_logging_bucket"
logging_prefix                       = "logs/"
lifecycle_rules                      = {
  example_rule1 = {
    enabled              = true
    prefix               = "example/"
    transition_days      = 30
    transition_storage_class = "INTELLIGENT_TIERING"
    expiration_days      = 365
  }
}
replication_role                     = "arn:aws:iam::123456789012:role/replication-role"
replication_destination_bucket_arn   = "arn:aws:s3:::destination-bucket"
common_tags                          = {
  Environment = "Production"
  Owner       = "YourName"
}
