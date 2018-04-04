name 'nscd'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures nscd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '5.0.2'

recipe 'nscd::default', 'Installs and configures nscd'

%w(ubuntu debian fedora centos redhat oracle scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/nscd'
issues_url 'https://github.com/chef-cookbooks/nscd/issues'
chef_version '>= 12.5' if respond_to?(:chef_version)
