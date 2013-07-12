strainer-berkshelf-chefspec-recursive-bug Cookbook
==================================================
This cookbook is a demo cookbook for reproducing a bug in [Strainer](https://github.com/customink/strainer).  It includes a semi-workaround for the recursive creation of `vendor/cookbooks` directories.

It also demonstrates a couple useful things for testing Chef cookbooks:

 - A way to detect that Strainer is in use from within rspec
 - The use of [chefspec](https://github.com/acrmp/chefspec), a gem that enables you to write rspec tests for your chef recipes without having to actually run them on a node.
 - Allowing the testing a cookbook with dependencies via standalone rspec: `bundle exec rspec` (by using [Berkshelf](http://berkshelf.com/))

You can [learn about chefspec here](https://www.relishapp.com/acrmp/chefspec/docs) You can [learn about RSpec here](https://www.relishapp.com/rspec) And of course chef is at http://wiki.opscode.com/display/chef/Home

To install: clone this repo, install Bundler (gem install bundler), and install the chefspec gems via bundler (bundle install).

You can run the tests any of 4 ways:

 1. Within the fake chef repo:
   - `bundle exec rspec cookbooks/strainer-berkshelf-chefspec-recursive-bug/`
   - `strainer test strainer-berkshelf-chefspec-recursive-bug` (optionally add: `-d` for strainer's debug output)
 3. Within the cookbook dir itself:
   - `cd cookbooks/strainer-berkshelf-chefspec-recursive-bug && bundle exec rspec`
   - `cd cookbooks/strainer-berkshelf-chefspec-recursive-bug && strainer test`

Requirements
------------

#### packages
- `chef-solo-search` - strainer-berkshelf-chefspec-recursive-bug needs chef-solo-search to test recipes that use search.

Attributes
----------
N/A

Usage
-----
#### strainer-berkshelf-chefspec-recursive-bug::default

Just include `strainer-berkshelf-chefspec-recursive-bug` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[strainer-berkshelf-chefspec-recursive-bug]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: James Cuzella
