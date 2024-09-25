//create s3 bucket and set permissions
resource "aws_s3_bucket" "static_website" {
  bucket = "my-static-website-bucket-198745"
  tags = {
    "Name" = "Website Bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "static_website" {
  bucket = aws_s3_bucket.static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket                    = aws_s3_bucket.static_website.id
  block_public_acls         = false
  block_public_policy       = false
  ignore_public_acls        = false
  restrict_public_buckets   = false
}

resource "aws_s3_bucket_acl" "static_website" {
  depends_on = [ 
    aws_s3_bucket_ownership_controls.static_website,
    aws_s3_bucket_public_access_block.static_website,
  ]
  bucket = aws_s3_bucket.static_website.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id
  
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_policy" "static_website" {
  depends_on  = [ aws_s3_bucket_acl.static_website ]
  bucket      = aws_s3_bucket.static_website.id
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
        Principal = "*"
      },
    ]
  })
}