require 'bundler/setup'
require 'chefspec'
require 'berkshelf'
require 'strainer'
require 'fileutils'
require_relative 'support/chefspec_helpers.rb'

# Check for strainer by comparing parent tmp directory paths
using_strainer = File.dirname(ENV['PWD']) != File.dirname(Strainer.sandbox_path.to_s) ? false : true

## Note: These will only return the real sandbox paths if you comment out
##       this line of your strainer gem: https://github.com/customink/strainer/blob/master/lib/strainer/command.rb#L96
# debug_output 'Dir.pwd', Dir.pwd
# debug_output 'PWD', ENV['PWD']
# debug_output 'File.dirname(__FILE__)', File.dirname(__FILE__)
# debug_output 'Dir.getwd', Dir.getwd
# debug_output 'Strainer Sandbox', Strainer.sandbox_path.to_s
# debug_output 'Using Strainer', using_strainer
## This doesn't work
# require 'strainer/sandbox'
# puts "Strainer::Sandbox.chef_repo? #{Strainer::Sandbox.chef_repo?}"

# Detect if we're running within strainer, and change COOKBOOK_PATH accordingly
# This is becauase Strainer uses Berkshelf to install cookbook dependencies itself.
# This also works around a recursive require issue with Strainer
if ! using_strainer && ! defined?(BERKS_INSTALLED)
  COOKBOOK_PATH = File.join 'vendor', 'cookbooks'
  puts "Strainer not detected ... setting cookbook path to #{COOKBOOK_PATH}"
  puts "Running berks install ..."
  berksfile = Berkshelf::Berksfile.from_file('Berksfile')
  berksfile.install(path: COOKBOOK_PATH)
  BERKS_INSTALLED = true
elsif using_strainer
  puts "Strainer detected"

  # Strainer replaces all occurrences of the sandbox path, so behind the scenes all sandbox paths are correct,
  # but displaying it to the user could cause confusion, since it'll be replaced
  # To see what's really going on, comment line 96 in #{GEM_PATH}/strainer-3.0.4/lib/strainer/command.rb
  
  COOKBOOK_PATH = ENV['PWD']
  # puts "Strainer detected... setting cookbook path to #{COOKBOOK_PATH}"

  # Hack to search the Ruby ObjectSpace for the RSpec configuration object... this is the only way we can
  # find the real path to the cookbook under test since strainer started rspec in another thread,
  # we cannot access the Strainer object, and any Strainer.sandbox_path is a new tmp dir... NOT the one we're actually in :-(
  ObjectSpace.each_object(RSpec::Core::ConfigurationOptions) do |obj|
    # puts "RSpec files or dirs: #{obj.options[:files_or_directories_to_run]}"

    obj.options[:files_or_directories_to_run].each do |str|
      # Check the path by comparing parent tmp directory paths
      if File.dirname(File.dirname(str)) == File.dirname(Strainer.sandbox_path.to_s)
        # puts "Found path to cookbook under test: #{str}"
        COOKBOOK = str
      end
    end
  end

  # Remove any recursively created vendor/cookbooks paths that may exist within sandbox
  # if you have previously run 'bundle exec rspec' or berks install --path 'vendor/cookbooks'
  # NOTE: If you have an existing 'vendor/cookbooks' dir in the NON-sandboxed dir for cookbook under test,
  #       Then any 'strainer test' run seems to use cookbooks in this dir.
  #       Berkshelf appears to override Strainer's sandboxed cookbook path, so tests fail if we remove the top-level vendor/cookbooks
  #       under the COOKBOOK (under test) path.
  berks_vendor_cookbooks = File.join( COOKBOOK, 'vendor', 'cookbooks', File.basename(COOKBOOK), 'vendor' )
  if Dir.exists? berks_vendor_cookbooks
    puts "Removing any recursive vendor/cookbooks..."
    # puts "Removing: #{berks_vendor_cookbooks}"
    FileUtils.rm_rf berks_vendor_cookbooks
  end
  
  # Removing recursively copied RSpec dirs causes problems... strainer test runs will still have some duplicated tests...
  
  # recursive_rspec_dir = File.join( COOKBOOK, 'vendor', 'cookbooks', File.basename(COOKBOOK), 'spec' )
  # if Dir.exists? recursive_rspec_dir
  #   puts "Removing any recursive spec dirs..."
  #   puts "Removing: #{recursive_rspec_dir}"
  #   FileUtils.rm_rf recursive_rspec_dir
  # end
  
end
