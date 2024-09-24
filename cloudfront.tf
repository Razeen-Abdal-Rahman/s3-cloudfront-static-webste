//create and configure cloudfront distribution
resource "aws_cloudfront_distribution" "static_website" {
  origin {
    domain_name = aws_s3_bucket.static_website.website_endpoint
    origin_id = "s3-${aws_s3_bucket.static_website.id}"
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http_only"
      origin_ssl_protocols = "TLSv1"
    }
  }
  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = [ "GET", "HEAD" ]
    cached_methods = [ "GET", "HEAD" ]
    target_origin_id = "S3-${aws_s3_bucket.static_website.id}"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = [ "GB" ]
    }
  }
}