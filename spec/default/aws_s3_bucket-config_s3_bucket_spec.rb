require 'awspec'
require './ec2_helper'

describe s3_bucket(EC2Helper::GetS3BucketIdFromName('acmecorp-config-global-development-acmecorp-us-east-1')) do
  it { should exist }
end
