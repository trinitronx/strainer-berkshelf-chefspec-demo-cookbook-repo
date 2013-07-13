strainer-berkshelf-chefspec-demo-cookbook-repo
==============================================
This is a fake Chef Repo structure to demonstrate the usage of chefspec, Strainer, and Berkshelf for cookbook management and testing. 
It contains a cookbook to reproduce a bug in Strainer, and demonstrate some useful things.


strainer-berkshelf-chefspec-recursive-bug Cookbook
==================================================
This cookbook is a demo cookbook for reproducing a bug in [Strainer](https://github.com/customink/strainer).  It includes a semi-workaround for the recursive creation of `vendor/cookbooks` directories.

To reproduce the bug:

 1. Run `cd cookbooks/strainer-berkshelf-chefspec-recursive-bug && bundle exec rspec`
 2. Notice 1 test passes
 3. Run `cd cookbooks/strainer-berkshelf-chefspec-recursive-bug; strainer test`
 4. Notice output `2 examples, 0 failures`, duplicated RSpec tests, and recursively copied path in Strainer sandbox: 
 `#{Strainer.sandbox_path.to_s}/strainer-berkshelf-chefspec-recursive-bug/vendor/cookbooks/strainer-berkshelf-chefspec-recursive-bug/spec/`
 5. Repeat Step 1.
 6. Repeat Step 3.
 7. Notice yet another recursive directory created in `vendor/cookbooks`, and tests fail with **LoadError**:
 `#{Strainer.sandbox_path.to_s}/strainer-berkshelf-chefspec-recursive-bug/vendor/cookbooks/strainer-berkshelf-chefspec-recursive-bug/vendor/cookbooks/strainer-berkshelf-chefspec-recursive-bug/spec/default_spec.rb`

Please see `spec/spec_helper.rb` for some debug info & help to see what is going on.

It also intends to be a [development spike](http://www.extremeprogramming.org/rules/spike.html) and demonstrates a couple useful things for testing Chef cookbooks:

 - A way to detect that Strainer is in use from within rspec.
 - The use of [chefspec](https://github.com/acrmp/chefspec), a gem that enables you to write rspec tests for your chef recipes without having to actually run them on a node.
 - Allowing the testing a cookbook with dependencies via standalone rspec: `bundle exec rspec` (by using [Berkshelf](http://berkshelf.com/))
 - The use of encrypted data bags within chefspec tests.
 - Some useful chefspec helpers (See: `spec/support/chefspec_helpers.rb`)
 - How to allow the use of encrypted data bags within chefspec tests + a chefspec helper to stub out data bags.
 - Cookbook repo & Chef repo structure required to test multiple ways using Strainer.

You can [learn about chefspec here](https://www.relishapp.com/acrmp/chefspec/docs). You can [learn about RSpec here](https://www.relishapp.com/rspec).
You can [learn about Strainer here](https://github.com/customink/strainer). And of course chef can be found at [Opscode](http://wiki.opscode.com/display/chef/Home)

To install: clone this repo, install Bundler (`gem install bundler`), and install the chefspec gems via bundler (`bundle install`).

You can run the tests any of 3 ways:

 1. Within the fake chef repo:
   - `strainer test strainer-berkshelf-chefspec-recursive-bug` (optionally add: `-d` for strainer's debug output)
 3. Within the cookbook dir itself:
   - `cd cookbooks/strainer-berkshelf-chefspec-recursive-bug; bundle exec rspec`
   - `cd cookbooks/strainer-berkshelf-chefspec-recursive-bug; strainer test`

Requirements
------------

#### packages
- `chef-solo-search` - strainer-berkshelf-chefspec-recursive-bug needs chef-solo-search to test recipes that use search.


Known Bugs
----------

Currently cannot run RSpec from top-level chef repo due to *Chef::Exceptions::CookbookNotFound*:

 - [ ] Fix `bundle exec rspec cookbooks/strainer-berkshelf-chefspec-recursive-bug/`


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
