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
* `default['nscd']['logfile']`. Specifies name of the file to which debug info should be written. Default `/var/log/nscd`
* `default['nscd']['threads']`. This is the number of threads that are started to wait for requests. At least five threads will always be created. Default `4`
* `default['nscd']['max_threads']`. Specifies the maximum number of threads. Default `32`
* `default['nscd']['server_user']`. If this option is set, `nscd` will run as this user and not as `root`. If a separate cache for every user is used (`-S` parameter), this option is ignored. Default `nscd`
* `default['nscd']['stat_user']`. Specifies the user who is allowed to request statistics. Default `root`
* `default['nscd']['debug_level']`. Sets the desired debug level. Default `0`
* `default['nscd']['reload_count']`. Limit on the number of times a cached entry gets reloaded without being used before it gets removed. Default `5`
* `default['nscd']['paranoia']`. Enabling paranoia mode causes `nscd` to restart itself periodically. Default `no`
* `default['nscd']['restart_interval']`. Sets the restart interval to time seconds if periodic restart is enabled by enabling `paranoia` mode. Default `3600`
* `default['nscd']['databases']`. List of databases to configure. Default `%[passwd group hosts services netgroup`]

Each database has attributes, default depends on `SERVICE`, see attribute file.
* `default['nscd'][SERVICE]['enable_cache']`. Enables or disables the specified `SERVICE` cache.
* `default['nscd'][SERVICE]['positive_time_to_live']`. Sets the TTL (time-to-live) for positive entries (successful queries) in the specified cache for service. Value is in seconds. Larger values increase cache hit rates and reduce mean response times, but increase problems with cache coherence.
* `default['nscd'][SERVICE]['negative_time_to_live']`. Sets the TTL (time-to-live) for negative entries (unsuccessful queries) in the specified cache for service. Value is in seconds. Can result in significant performance improvements if there are several files owned by UIDs (user IDs) not in system databases (for example untarring the Linux kernel sources as root); should be kept small to reduce cache coherency problems.
* `default['nscd'][SERVICE]['suggested_size']`. This is the internal hash table size, value should remain a prime number for optimum efficiency.
* `default['nscd'][SERVICE]['check_files']`. Enables or disables checking the file belonging to the specified service for changes. The files are `/etc/passwd`, `/etc/group`, `/etc/hosts`, `/etc/services` and `/etc/netgroup`.
* `default['nscd'][SERVICE]['persistent']`. Keep the content of the cache for service over server restarts; useful when `paranoia` mode is set.
* `default['nscd'][SERVICE]['shared']`. The memory mapping of the `nscd` databases for service is shared with the clients so that they can directly search in them instead of having to ask the daemon over the socket each time a lookup is performed.
* `default['nscd'][SERVICE]['max_db_size']`. The maximum allowable size, in bytes, of the database files for the service.
* `default['nscd'][SERVICE]['auto_propagate']`. When set to `no` for `passwd` or `group` service, then the `.byname` requests are not added to `passwd.byuid` or `group.bygid` cache. This can help with tables containing multiple records for the same ID. This option is valid only for services `passwd` and `group`.


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
