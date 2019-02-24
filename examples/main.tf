terraform {
  required_version = ">= 0.9.3"
}

provider "aws" {
  allowed_account_ids = [
    "${var.user_account_id}"
  ]
  region = "${var.aws_region}"
}

module "config" {
    source  = "../."
    account_name = "${var.account_name}"
    business_unit = "${var.business_unit}"
    environment = "${var.environment}"
    aws_region = "${var.aws_region}"
}
