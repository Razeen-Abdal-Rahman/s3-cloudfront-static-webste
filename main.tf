//set provider
provider "aws" {
  region = "eu-west-1"
}

//upload files to s3 bucket
resource "aws_s3_object" "index" {
  bucket    = aws_s3_bucket.static_website.id
  key       = "index.html"
  source    = "src/index.html"
}

resource "aws_s3_object" "error" {
  bucket    = aws_s3_bucket.static_website.id
  key       = "error.html"
  source    = "src/error.html"
}

//output endpoint url
output "website_endpoint" {
  value = aws_cloudfront_distribution.static_website.domain_name
}