require 'chefspec'
require_relative 'spec_helper'

describe 'strainer-berkshelf-chefspec-recursive-bug::default' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.converge described_recipe
  }

  it 'should do nothing' do
    expect(chef_run).to be_instance_of(ChefSpec::ChefRunner)
  end

end
