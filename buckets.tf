resource "aws_s3_bucket" "s3_remote_state" {
  bucket        = var.remote_bucket_name
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "s3_remote_versioning" {
  bucket = aws_s3_bucket.s3_remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.s3_remote_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}