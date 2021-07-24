module "all_lambdas" {
  source = "./resources/lambda"
  prefix   = var.prefix
  tags   = var.tags
}

module "all_buckets" {
  source = "./resources/s3"
  prefix   = var.prefix
  tags   = var.tags
}
