#
# Cookbook Name:: strainer-berkshelf-chefspec-recursive-bug
# Recipe:: default
#
# Copyright 2013, James Cuzella
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Get the AWS keys from encrypted data bags
aws_keys = Hash.new
%w{ database-backup media-assets s3-log-upload github-repo-backup }.each do |user|
  aws_keys[user] = Chef::EncryptedDataBagItem.load('aws', user)
end

template '/etc/environment' do
  source "environment.erb"
  owner "root"
  group "root"
  variables(
    :aws_keys => aws_keys
  )
  mode "0600"
end
