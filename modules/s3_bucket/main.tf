provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = var.logging_bucket
    target_prefix = var.logging_prefix
  }

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

  replication_configuration {
    role           = var.replication_role
    destination {
      bucket = var.replication_destination_bucket_arn
    }
  }

  tags = merge(var.common_tags, { Name = var.bucket_name })
}
