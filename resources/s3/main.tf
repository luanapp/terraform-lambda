module "luana_pimentel_buckets" {
  source = "../../modules/s3"

  buckets = ["${var.prefix}-bconfd-update-lambda"]

  tags = var.tags
}