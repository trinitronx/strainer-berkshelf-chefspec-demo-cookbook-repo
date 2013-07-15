require 'chefspec'
require_relative 'spec_helper'

describe 'strainer-berkshelf-chefspec-recursive-bug::chef_solo_search' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.converge described_recipe
  }

  it 'should test the use of search' do
      pending 'TODO'
  end

end
