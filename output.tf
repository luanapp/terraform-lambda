output "lambda_arn" {
  value = module.all_lambdas.lambda_arn
}
output "bucket_arn" {
  value = module.all_buckets[*].bucket_arn
}
