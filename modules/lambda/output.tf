output "lambda_arn" {

  value = {
    for k, v in aws_lambda_function.this : k => v.arn
  }
}
