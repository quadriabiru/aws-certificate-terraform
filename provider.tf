terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0" # latest version is 5.37
    }
  }
}

provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}