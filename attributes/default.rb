#
# Cookbook:: nscd
# Attributes:: default
#
# Copyright:: 2009-2016, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'etc'

# nscd cookbook(in case you need to override anything in a wrapper)
default['nscd']['template_cookbook'] = 'nscd'

# Possible values: nscd, unscd, gnscd
default['nscd']['package'] = 'nscd'
default['nscd']['version'] = nil

# nscd.conf parameters
default['nscd']['logfile'] = '/var/log/nscd'
default['nscd']['threads'] = 4
default['nscd']['max_threads'] = 32
default['nscd']['server_user'] =
  begin
    Etc.getpwnam('nscd')
    'nscd'
  rescue ArgumentError
    'nobody'
  end
default['nscd']['stat_user'] = 'root'
default['nscd']['debug_level'] = 0
default['nscd']['reload_count'] = 5
default['nscd']['paranoia'] = 'no'
default['nscd']['restart_interval'] = 3600

# list of databases which to configure
default['nscd']['databases'] = %w(passwd group hosts services netgroup)

# passwd database
default['nscd']['passwd']['enable_cache'] = 'yes'
default['nscd']['passwd']['positive_time_to_live'] = 600
default['nscd']['passwd']['negative_time_to_live'] = 20
default['nscd']['passwd']['suggested_size'] = 211
default['nscd']['passwd']['check_files'] = 'yes'
default['nscd']['passwd']['persistent'] = 'yes'
default['nscd']['passwd']['shared'] = 'yes'
default['nscd']['passwd']['max_db_size'] = 0x2000000
default['nscd']['passwd']['auto_propagate'] = 'yes'

# group database
default['nscd']['group']['enable_cache'] = 'yes'
default['nscd']['group']['positive_time_to_live'] = 3600
default['nscd']['group']['negative_time_to_live'] = 60
default['nscd']['group']['suggested_size'] = 211
default['nscd']['group']['check_files'] = 'yes'
default['nscd']['group']['persistent'] = 'yes'
default['nscd']['group']['shared'] = 'yes'
default['nscd']['group']['max_db_size'] = 0x2000000
default['nscd']['group']['auto_propagate'] = 'yes'

# hosts database
default['nscd']['hosts']['enable_cache'] = 'yes'
default['nscd']['hosts']['positive_time_to_live'] = 3600
default['nscd']['hosts']['negative_time_to_live'] = 20
default['nscd']['hosts']['suggested_size'] = 211
default['nscd']['hosts']['check_files'] = 'yes'
default['nscd']['hosts']['persistent'] = 'yes'
default['nscd']['hosts']['shared'] = 'yes'
default['nscd']['hosts']['max_db_size'] = 0x2000000

# services database
default['nscd']['services']['enable_cache'] = 'yes'
default['nscd']['services']['positive_time_to_live'] = 28_800
default['nscd']['services']['negative_time_to_live'] = 20
default['nscd']['services']['suggested_size'] = 211
default['nscd']['services']['check_files'] = 'yes'
default['nscd']['services']['persistent'] = 'yes'
default['nscd']['services']['shared'] = 'yes'
default['nscd']['services']['max_db_size'] = 0x2000000

# services netgroup
# netgroup caching is known-broken, so disable it in the default config,
# see: https://bugs.launchpad.net/ubuntu/+source/eglibc/+bug/1068889
default['nscd']['netgroup']['enable_cache'] = 'no'
default['nscd']['netgroup']['positive_time_to_live'] = 28_800
default['nscd']['netgroup']['negative_time_to_live'] = 20
default['nscd']['netgroup']['suggested_size'] = 211
default['nscd']['netgroup']['check_files'] = 'yes'
default['nscd']['netgroup']['persistent'] = 'yes'
default['nscd']['netgroup']['shared'] = 'yes'
default['nscd']['netgroup']['max_db_size'] = 0x2000000
