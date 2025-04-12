resource "random_uuid" "s3_uuid" {}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${var.bucket_name_prefix}-${random_uuid.s3_uuid.result}" # Unique bucket name
  force_destroy = true

  tags = {
    Name        = "${var.environment}-Private-S3-Bucket"
    Environment = var.environment
  }
}

#  Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "s3_block_public_access" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#  Server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
  }
}

#  Lifecycle rule to transition objects to STANDARD_IA
resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id     = "transition-to-IA"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

#  Deny public access via bucket policy
resource "aws_s3_bucket_policy" "s3_deny_public" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "aws:PrincipalType" : "Anonymous"
          }
        }
      }
    ]
  })
}
