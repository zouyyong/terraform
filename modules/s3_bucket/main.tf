#define aws provider 
provider "aws" {
  region = var.region
}

# state file backend 
terraform {
  backend "s3" {}
}

# define s3 bucket 
resource "aws_s3_bucket" "terragrunt_bucket" {
  bucket = var.bucket_name
  acl    = "private"

# enable versioning 
  versioning {
    enabled = true
  }

#enable encryption 
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

#enable logging , specify loggingbucket 
  logging {
    target_bucket = var.logging_bucket
    target_prefix = var.logging_prefix
  }

#define bucket lifecycle rule 
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules

    content {
      enabled = lifecycle_rule.value.enabled
      id      = lifecycle_rule.key
      prefix  = lifecycle_rule.value.prefix

      transition {
        days          = lifecycle_rule.value.transition_days
        storage_class = lifecycle_rule.value.transition_storage_class
      }

      expiration {
        days = lifecycle_rule.value.expiration_days
      }
    }
  }

#define replication rule 
  replication_configuration {
    role           = var.replication_role
    rules {
        id = "foobar"

        status = "Enabled"

        destination {
        bucket        = var.replication_destination_bucket_arn
        storage_class = "STANDARD"
        }
    }
  }
   

  tags = merge(var.common_tags, { Name = var.bucket_name })
}
