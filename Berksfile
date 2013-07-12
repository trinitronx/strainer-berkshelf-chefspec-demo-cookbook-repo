chef_api :config
site :opscode

# Assumes you're in a cookbook repo with chef-solo-search
# You may need this if you run into: http://tickets.opscode.com/browse/CHEF-672
#cookbook 'chef-solo-search', path: "#{File.join File.dirname(__FILE__), '..', 'cookbooks', 'chef-solo-search'}"

cookbook 'chef-solo-search', github: 'edelight/chef-solo-search', tag: '0.4.0'

cookbook 'strainer-berkshelf-chefspec-demo-cookbook-repo', github: 'trinitronx/strainer-berkshelf-chefspec-demo-cookbook-repo'

## Not valid in top-level chef repo
#metadata
