variable "lambda_role" {
  type        = map(string)
  description = "This map must contain the role name (\"name\") and the role arn (\"arn\")"

  default = {
    "name" = "role_name"
    "arn"  = "role_arn"
  }
}

variable "lambda_execution_policy" {
  type        = string
  description = "Policy to attach to the lambda role. Used in the lambda execution"
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

variable "lambda" {
  description = "It can create several lambdas at once, which will have the same role provided by var.lambda_role"
  type = map(object({
    function_name = string
    runtime       = string
    handler       = string

    lambda_source_bucket     = string
    lambda_source_bucket_key = string

    lambda_cron_schedule         = string
    lambda_cron_schedule_enabled = bool
  }))
}

variable "tags" {
  type        = map(string)
  description = "key-value default mapping for the resource tags"
}
