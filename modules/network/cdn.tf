resource "aws_cloudfront_distribution" "web" {
    enabled = true
    price_class = "PriceClass_100"
    aliases = ["jdkresume.com", "www.jdkresume.com"]

    origin {
        domain_name = var.alb-dns-name # The DNS domain name of the alb from which you want CloudFront to get objects for this origin.
        origin_id = var.alb-dns-name # A unique identifier for the origin.

        custom_origin_config {
            http_port = 80 # The HTTP port the custom origin listens on.
            https_port = 443 # The HTTPS port the custom origin listens on.
            origin_protocol_policy = "http-only" # The protocol policy that you want CloudFront to use when fetching objects from your origin. 
            origin_ssl_protocols = ["TLSv1"] # The minimum TLS/SSL protocol that CloudFront can use when it establishes an HTTPS connection to your origin. 
        }
    }

    default_root_object = "index.html"

    default_cache_behavior { # Defines CloudFront's default response when it receives a request for objects.
        allowed_methods = ["GET", "HEAD", "OPTIONS"] # The HTTP methods that you want CloudFront to process and forward to your origin.
        cached_methods = ["GET", "HEAD"]
        target_origin_id = var.alb-dns-name # The origin_id of the origin you want CloudFront to forward your requests to.
        viewer_protocol_policy = "redirect-to-https" # The protocol policy that you want viewers to use to access your content in CloudFront edge locations.

        forwarded_values {
            query_string = false # Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior.
            
            cookies {
                forward = "none"
            }
        }
    }

    restrictions { 
        geo_restriction {
          restriction_type = "whitelist"
          locations = ["US", "CA"]
        }
    }

    viewer_certificate { # The SSL configuration for this distribution
        acm_certificate_arn = aws_acm_certificate.cert.arn # The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution.
        minimum_protocol_version = "TLSv1" # The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections.
        ssl_support_method = "sni-only" # Specifies how you want CloudFront to serve HTTPS requests.
    }
}


