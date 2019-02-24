# terraform-config-baseline

Enables AWS Config and adds managed config rules with good defaults.

aws configservice describe-configuration-recorders
aws configservice delete-configuration-recorder --configuration-recorder-name default

aws configservice describe-delivery-channels
aws configservice delete-delivery-channel --delivery-channel-name default-delivery-channel
---

## Introduction

The module provisions the following resources:

- aws_config_configuration_recorder_status
- aws_iam_role_policy_attachment
- aws_s3_bucket
- aws_config_delivery_channel
- aws_config_configuration_recorder
- aws_iam_role
- aws_iam_role_policy


The following CIS controls are implemented:
- 2.5 Ensure AWS Config is enabled in all regions (must be set to global) 
## Usage


For a complete example, see [examples]

```hcl
module "config" {
    source  = "../../../../../modules/terraform-config-baseline/."
    environment = "${var.environment}"
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment | Environment name | `<string>` | yes |
| config_s3_bucket | S3 bucket for Config | `<string>` | yes, default set |
| config_delivery_channel | Delivery channel name | `<string>` | yes, default set |
| config_recorder | Recorder name | `<string>` | yes, default set |
| config_iam_role | IAM role name | `<string>` | yes, default set |
| config_iam_policy | IAM policy name| `<string>` | yes, default set |