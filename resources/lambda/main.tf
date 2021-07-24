data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "lambda_example" {
  bucket   = "${var.prefix}-lambda_example"
}

data "aws_s3_bucket_object" "bconfd_update_lambda_file" {
  bucket   = data.aws_s3_bucket.update.id
  key      = "function-v1.zip"
}

module "luana_pimentel_lambdas" {
  source = "../../modules/lambda"

  lambda_role = {
    "name" = "${var.prefix}-role_lambda"
    "arn"  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.prefix}-role_lambda"
  }

  lambda = {
    "bconf-update" : {
      function_name = "${var.prefix}-bconfd-update"
      runtime       = "go1.x"
      handler       = "main"

      lambda_source_bucket     = aws_s3_bucket.bconfd_update_lambda.id
      lambda_source_bucket_key = aws_s3_bucket_object.bconfd_update_lambda_file.key

      lambda_cron_schedule         = "rate(1 minute)"
      lambda_cron_schedule_enabled = true
    }
  }

  tags = var.tags
}
