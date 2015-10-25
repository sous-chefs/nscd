nscd Cookbook CHANGELOG
=======================
This file is used to list changes made in each version of the nscd cookbook.

v2.0.0 (2015-10-24)
-------------------
* Breaking change: Changed the execute block for performing nscd database cache clears in wrapper cookbooks to a Chef 12.5 custom resource that can more easily clear the cache for multiple databases.  This will require updating cookbooks that notified to the previous execute block and requires Chef 12.0 or greater.

v1.0.1 (2015-10-24)
-------------------
* Added additional platforms added to Test Kitchen config
* Added the standard Chef Rubocop config
* Updated Travis CI to use Chef DK for testing instead of Gems
* Updated contributing and testing docs
* Updated testing deps in the Gemfile
* Added maintainers.toml and maintainers.md
* Added a Rakefile for simplified testing
* Updated links to the Github org to point to the new chef-cookbooks org

v1.0.0 (2015-09-05)
-------------------
* Minimum supported Chef release is now 11
* Added `default['nscd']['version']` to control the version of the nscd package to install
* Removed use of Ruby 1.8.7 hash rockets
* Added source_url and issue_url metadata
* Added additional platforms to the Kitchen CI config
* Removed Ruby 1.9.3 from Travis CI and add 2.1 and 2.2
* Removed the version constraint on apt in the Berkshelf file
* Updated developent dependencies and break Gemfile into groups
* Added cookbook version badge to the readme

v0.13.0
-------
* Template the nscd config before starting the service so we don't have to start then restart
* Added a chefignore file
* Added Fedora as supported in metadata / Readme
* Update testing and contributing docs to match JIRA-free process
* Update development dependencies to current versions (chefspec, berkshelf, foodcritic, test kitchen, and rubocop)
* Update chefspec / server spec to work with the newer releases
* Add Trusty to the test kitchen config

v0.12.0
-------
- Manage /etc/nscd.conf with a template

v0.11.0
-------
### Improvement
- **[COOK-3607](https://tickets.chef.io/browse/COOK-3607)** - Add support for different `nscd` packages


v0.10.0
-------
### Improvement
- **[COOK-1915](https://tickets.chef.io/browse/COOK-1915)** - Add SmartOS support

v0.9.0
------
### Improvement
- [COOK-1915] - Support SmartOS for nscd

v0.8.2
------
- [COOK-1993] - use install action for packages

v0.7.0
------
- Current public release
