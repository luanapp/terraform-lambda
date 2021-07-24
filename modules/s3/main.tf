resource "aws_kms_key" "this" {
  deletion_window_in_days = 10

  description = "This key is used to encrypt bucket objects"
}

resource "aws_s3_bucket" "this" {
  count = length(var.buckets)


  bucket = var.buckets[count.index]
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.this.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = var.tags
}
