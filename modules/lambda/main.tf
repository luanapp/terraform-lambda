data "aws_s3_bucket" "this" {
  for_each = var.lambda
  bucket   = each.value.lambda_source_bucket
}

data "aws_s3_bucket_object" "this" {
  for_each = var.lambda
  bucket   = data.aws_s3_bucket.this[each.key].id
  key      = each.value.lambda_source_bucket_key
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = var.lambda_role["name"]
  policy_arn = var.lambda_execution_policy
}

resource "aws_cloudwatch_event_rule" "this" {
  for_each = var.lambda

  name                = replace("${each.value.function_name}-cron_schedule", "/(.{0,64}).*/", "$1")
  description         = "This event will run according to a schedule for Lambda ${each.value.function_name}"
  schedule_expression = each.value.lambda_cron_schedule
  is_enabled          = each.value.lambda_cron_schedule_enabled
}

resource "aws_cloudwatch_event_target" "this" {
  for_each = var.lambda

  rule = aws_cloudwatch_event_rule.this[each.key].name
  arn  = aws_lambda_function.this[each.key].arn
}

resource "aws_lambda_permission" "this" {
  for_each = var.lambda

  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = each.value.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this[each.key].arn
}

resource "aws_lambda_function" "this" {
  for_each      = var.lambda
  function_name = each.value.function_name

  s3_bucket = data.aws_s3_bucket.this[each.key].id
  s3_key    = data.aws_s3_bucket_object.this[each.key].key

  runtime = each.value.runtime
  handler = each.value.handler


  role = var.lambda_role["arn"]

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "this" {
  for_each = var.lambda
  name     = "/aws/lambda/${aws_lambda_function.this[each.key].function_name}"

  retention_in_days = 30

  tags = var.tags
}

