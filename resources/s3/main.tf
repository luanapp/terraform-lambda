module "content_knowledge_buckets" {
  source = "../../modules/s3"

  buckets = ["${var.prefix}-bconfd-update-lambda"]

  tags = var.tags
}