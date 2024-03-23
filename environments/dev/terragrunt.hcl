
# start with remote_state management
remote_state {
  backend = "s3"
  config = {
    bucket         = "yz-testing"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state"
  }
}

# environment specific inputs 
inputs = {

#inputs used by s3 bucket module 
  region                               = "us-east-1"
  bucket_name                          = "yz-terragrunt"
  logging_bucket                       = "yz-tarraform-testing"
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

  replication_role                     = "arn:aws:iam::483413011187:role/s3replication"
  replication_destination_bucket_arn   = "arn:aws:s3:::yz-machinelearning"

  common_tags                          = {
    Environment = "dev"
  }

#inputs used by s3 bucket module 
  lambda_bucket = "yz-tarraform-testing"




}
