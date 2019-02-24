require 'awspec'
require './ec2_helper'

describe iam_role(EC2Helper::GetIAMRoleWhichBeginsWith('config-global-role-test')) do
  it { should exist }
end
