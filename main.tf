resource "aws_config_configuration_recorder_status" "config_rec_status" {
  name       = "${aws_config_configuration_recorder.config_recorder.name}"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.config_delivery_channel"]
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = "${aws_iam_role.config_iam_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_s3_bucket" "config_s3_bucket" {
  bucket = "${var.config_s3_bucket}-${var.account_name}-${var.business_unit}-${var.aws_region}" 
  force_destroy = "${var.s3_force_destroy}"
}

resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = "${var.config_delivery_channel}-${var.environment}" 
  s3_bucket_name = "${aws_s3_bucket.config_s3_bucket.bucket}"
}

resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "${var.config_recorder}-${var.account_name}-${var.business_unit}-${var.aws_region}" 
  role_arn = "${aws_iam_role.config_iam_role.arn}"
  recording_group = {
      all_supported = "true"
      include_global_resource_types = "true"
  }
}

resource "aws_iam_role" "config_iam_role" {
  name = "${var.config_iam_role}-${var.environment}" 

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "config_iam_policy" {
  name = "${var.config_iam_policy}-${var.account_name}-${var.business_unit}-${var.aws_region}"
  role = "${aws_iam_role.config_iam_role.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.config_s3_bucket.arn}",
        "${aws_s3_bucket.config_s3_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}