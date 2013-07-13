require 'chefspec'
require_relative 'spec_helper'

describe 'strainer-berkshelf-chefspec-recursive-bug::stub_data_bag' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.converge described_recipe
  }

  let(:demo_user_data_bag) {
      {"id"=>"demo",
         "groups"=>["demo"],
         "uid"=>1020,
         "gid"=>1020,
         "shell"=>"/bin/bash",
         "comment"=>"Demo Account",
         "password"=>"!!",
         "ssh_keys"=>
           ["ssh-rsa TODO: Demo key\n"]
       }
    }

  it 'should test some stubbed data bags with a helper' do
      pending 'TODO'
  end

end
