# nscd Cookbook CHANGELOG

This file is used to list changes made in each version of the nscd cookbook.

## 5.0.2 (2018-04-04)

- Remove apt from the Berksfile
- Travis: Test the custom resource and test Debian
- Resolve Chef 14 deprecation

## 5.0.1 (2018-02-15)

- Test with delivery local mode and cleanup the test cookbook
- Don't use kind_of in the custom resource (FC117)
- Fix a bad example in the readme

## 5.0.0 (2017-02-23)

- Require Chef 12.5+ and remove compat_resource dependency

## v4.1.0 (2016-06-10)

- Add a new attribute 'template_cookbook' to allow specifying a cookbook containing the nscd config template for wrapper cookbooks

## v4.0.0 (2016-05-12)

- The NSCD user / group is now set to nscd if the nscd user/group exist and if not it will run as nobody. This is most likely the desired behavior for users, but may be a surprise based on the previous behavior.

## v3.0.0 (2016-04-29)

- NSCD database values are now sanitized to remove incompatible databases on RHEL < 6 and Debian < 8\. services and netgroup will now be removed as necessary

## v2.0.0 (2015-10-24)

- Breaking change: Changed the execute block for performing nscd database cache clears in wrapper cookbooks to a Chef 12.5 custom resource that can more easily clear the cache for multiple databases. This will require updating cookbooks that notified to the previous execute block and requires Chef 12.0 or greater.

## v1.0.1 (2015-10-24)

- Added additional platforms added to Test Kitchen config
- Added the standard Chef Rubocop config
- Updated Travis CI to use Chef DK for testing instead of Gems
- Updated contributing and testing docs
- Updated testing deps in the Gemfile
- Added maintainers.toml and maintainers.md
- Added a Rakefile for simplified testing
- Updated links to the Github org to point to the new chef-cookbooks org

## v1.0.0 (2015-09-05)

- Minimum supported Chef release is now 11
- Added `default['nscd']['version']` to control the version of the nscd package to install
- Removed use of Ruby 1.8.7 hash rockets
- Added source_url and issue_url metadata
- Added additional platforms to the Kitchen CI config
- Removed Ruby 1.9.3 from Travis CI and add 2.1 and 2.2
- Removed the version constraint on apt in the Berkshelf file
- Updated developent dependencies and break Gemfile into groups
- Added cookbook version badge to the readme

## v0.13.0

- Template the nscd config before starting the service so we don't have to start then restart
- Added a chefignore file
- Added Fedora as supported in metadata / Readme
- Update testing and contributing docs to match JIRA-free process
- Update development dependencies to current versions (chefspec, berkshelf, foodcritic, test kitchen, and rubocop)
- Update chefspec / server spec to work with the newer releases
- Add Trusty to the test kitchen config

## v0.12.0

- Manage /etc/nscd.conf with a template

## v0.11.0

### Improvement

- **[COOK-3607](https://tickets.chef.io/browse/COOK-3607)** - Add support for different `nscd` packages

## v0.10.0

### Improvement

- **[COOK-1915](https://tickets.chef.io/browse/COOK-1915)** - Add SmartOS support

## v0.9.0

### Improvement

- [COOK-1915] - Support SmartOS for nscd

## v0.8.2

- [COOK-1993] - use install action for packages

## v0.7.0

- Current public release
