# Creates SSL certificate
resource "aws_acm_certificate" "example" {
    domain_name = "*.${var.root_domain_name }" 
    #subject_alternative_names =  ["*.${var.root_domain_name}"] # requesting SSL cert for subdomains
    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }    

}

data "aws_route53_zone" "example" { # data tag is used to reference a resource we already have in aws
  name = "${var.root_domain_name }" # Name of my hosted zone -> useful later to get zone_id
  private_zone = false
}

# TO VALIDATE THAT A DOMAIN NAME BELONGS TO YOU, ACM WOULD GIVE YOU CNAME
# CNAME NEEDS TO BE ADDED TO RECORD SET IN ROUTE53 HOSTED ZONE
# create a record set in route 53 for domain validatation
resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

# validate acm certificates
resource "aws_acm_certificate_validation" "example" {
  certificate_arn = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

