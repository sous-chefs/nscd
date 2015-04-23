nscd Cookbook CHANGELOG
=======================
This file is used to list changes made in each version of the nscd cookbook.

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
