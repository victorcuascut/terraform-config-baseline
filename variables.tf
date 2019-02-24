variable "account_name" {}
variable "business_unit" {}
variable "aws_region" {}
variable "environment" {}
variable "s3_force_destroy" {
    default = "true"
}

variable "config_s3_bucket" {
    default = "acmecorp-config-global"
}
variable "config_delivery_channel" {
    default = "config-delivery-channel-global"
}
variable "config_recorder" {
    default = "config-recorder-global"
}
variable "config_iam_role" {
    default = "config-global-role"
}
variable "config_iam_policy" {
    default = "config-global-policy"
}