resource "random_uuid" "s3_uuid" {}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name_prefix}-${random_uuid.s3_uuid.result}" # Unique bucket name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "transition-to-IA"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  force_destroy = true

  tags = {
    Name        = "${var.environment}-Private-S3-Bucket"
    Environment = var.environment
  }
}