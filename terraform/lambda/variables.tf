variable "function_name" {
  type        = string
  description = "Lambda Function Name. The prefix `lambda-` is set to exclude the Role from aya-iam"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group#retention_in_days
variable "log_retention_in_days" {
  type        = number
  default     = 90
  description = "Lamda Function log (Cloudwatch Log)'s retention in days"
}
