nscd Cookbook
=============
[![Build Status](https://secure.travis-ci.org/opscode-cookbooks/nscd.png?branch=master)](http://travis-ci.org/opscode-cookbooks/nscd)

Installs and configures nscd.


Requirements
------------
### Platforms

- Debian/Ubuntu
- RHEL/CentOS
- SmartOS

Attributes
----------
* `default['nscd']['package']` - nscd package name, defaults to `nscd`. Other variants include: `unscd`, `gnscd`

The following attributes affect configuration of `/etc/nscd.conf`.
* `default['nscd']['logfile']`. Default `/var/log/nscd`
* `default['nscd']['threads']`. Default `4`
* `default['nscd']['max_threads']`. Default `32`
* `default['nscd']['server_user']`. Default `nscd`
* `default['nscd']['stat_user']`. Default `root`
* `default['nscd']['debug_level']`. Default `0`
* `default['nscd']['reload_count']`. Default `5`
* `default['nscd']['paranoia']`. Default `no`
* `default['nscd']['restart_interval']`. Default `3600`
* `default['nscd']['databases']`. List of databases to configure. Default `%[passwd group hosts services netgroup`]

Each database has attributes:
* `default['nscd'][DATABASE]['enable_cache']`. Default `yes`
* `default['nscd'][DATABASE]['positive_time_to_live']`. Default `600`
* `default['nscd'][DATABASE]['negative_time_to_live']`. Default `20`
* `default['nscd'][DATABASE]['suggested_size']`. Default `211`
* `default['nscd'][DATABASE]['check_files']`. Default `yes`
* `default['nscd'][DATABASE]['persistent']`. Default `yes`
* `default['nscd'][DATABASE]['shared']`. Default `yes`
* `default['nscd'][DATABASE]['max_db_size']`. Default `33554432`
* `default['nscd'][DATABASE]['auto_propagate']`. Default `yes`

Recipes
-------
### default
Installs nscd, manages the nscd service and makes available commands to clear the nscd databases (passwd and group) so they can be notified in other recipes (such as when managing openldap).


Usage
-----
If you're using nscd, add this recipe. If you need to notify the clear commands, e.g.,

```ruby
cookbook_file '/etc/nsswitch.conf' do
  source   'nsswitch.conf'
  notifies :run, 'execute[nscd-clear-passwd]', :immediately
  notifies :run, 'execute[nscd-clear-group]', :immediately
end
```


License & Authors
-----------------
- Author:: Joshua Timberman

```text
Copyright:: 2008-2013, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
