variable "region" {}
variable "bucket_name" {}
variable "logging_bucket" {}
variable "logging_prefix" {}
variable "lifecycle_rules" {
  type = map(object({
    enabled              = bool
    prefix               = string
    transition_days      = number
    transition_storage_class = string
    expiration_days      = number
  }))
}
variable "replication_role" {}
variable "replication_destination_bucket_arn" {}
variable "common_tags" {
  type = map(string)
}
