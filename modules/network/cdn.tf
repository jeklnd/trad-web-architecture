/*
resource "aws_cloudfront_distribution" "this" {
    origin {
        domain_name = "jdkresume.com"
        origin_id = 
    }
    default_cache_behavior {
      bucket = # The Amazon S3 bucket to store the access logs in
    }
    enabled = true
    restrictions =
    viewer_certificate =

}

resource "aws_s3_bucket" "cf-access-logs" {
    bucket = "cf-access-logs"

}
*/