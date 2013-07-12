module ChefSpecHelpers
    def setup_chefspec

        ## Lots of crappy boilerplate stuff we need to do for chefspec to work
        Chef::Config[:data_bag_path] = File.join(File.dirname(__FILE__), '../../test/integration/data_bags')
        Chef::Config[:solo] = true
        Chef::Config[:encrypted_data_bag_secret] = "#{ENV['HOME']}/.chef/encrypted_data_bag_secret"
    end
    def create_chefspec_runner
        setup_chefspec
        # puts "INSIDE #{__FILE__}: #{COOKBOOK_PATH}"
        chef_run = ChefSpec::ChefRunner.new({ :cookbook_path => COOKBOOK_PATH })
    end
end

module ChefSpecStubHelpers
    def stub_data_bag(args, retval)
        Chef::DataBagItem.any_instance.stub(:data_bag_item).and_return(Hash.new)
        Chef::DataBagItem.any_instance.stub(:data_bag_item).with(args).and_return(retval)
    end
end

class String
  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/).min.try(:size) || 0
    gsub(/^[ \t]{#{indent}}/, '')
  end
end

# Just a simple printf helper method
def debug_output(name, value)
    format_str = "%-24s: %s\n"
    printf format_str, name, value
end

# Make ChefSpecHelpers available within all 'describe' blocks
# Make ChefSpecStubHelpers available within all 'it' blocks
# https://www.relishapp.com/rspec/rspec-core/docs/helper-methods/define-helper-methods-in-a-module
RSpec.configure do |c|
    c.extend ChefSpecHelpers
    c.include ChefSpecStubHelpers
    c.include ChefSpecHelpers # allow use of create_chefspec_runner in 'let' block
end
