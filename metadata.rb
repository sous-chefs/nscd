name 'nscd'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures nscd'
version '5.0.2'

%w(ubuntu debian fedora centos redhat oracle scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/nscd'
issues_url 'https://github.com/chef-cookbooks/nscd/issues'
chef_version '>= 12.5'
