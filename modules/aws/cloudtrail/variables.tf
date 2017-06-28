variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name" {}

variable "kms_key_id" {
  default = ""
}

variable "enable_logging" {
  default = true
}

variable "enable_log_file_validation" {
  default = true
}

variable "include_global_service_events" {
  default = true
}

variable "is_multi_region_trail" {
  default = false
}

variable "s3_bucket_name" {
  default = ""
}

variable "s3_key_prefix" {
  default = ""
}

variable "force_destroy" {
  default = false
}

variable "expiration_days" {
  default = "30"
}

variable "cloud_watch_logs_role_arn" {
  default = ""
}

variable "cloud_watch_logs_group_arn" {
  default = ""
}

variable "sns_topic_name" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
