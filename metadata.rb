name              'nscd'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache 2.0'
description       'Installs and configures nscd'
version           '0.12.0'

recipe 'nscd', 'Installs and configures nscd'

%w(ubuntu debian fedora centos redhat oracle scientific amazon).each do |os|
  supports os
end

