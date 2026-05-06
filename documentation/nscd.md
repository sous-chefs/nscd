# nscd

Installs, configures, and manages the Name Service Cache Daemon service.

## Actions

* `:create` - Installs the package, writes the configuration file, and enables/starts the service.
* `:delete` - Stops/disables the service, removes the configuration file, and removes the package.

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `package_name` | String | `nscd` | Package to install. Other compatible package implementations can be supplied by wrappers. |
| `package_version` | String, nil | `nil` | Optional package version. |
| `manage_package` | true, false | `true` | Set to `false` when the package is managed elsewhere. |
| `config_path` | String | `/etc/nscd.conf` | Path to the generated configuration file. |
| `template_source` | String | `nscd.conf.erb` | Template source for the configuration file. |
| `template_cookbook` | String | `nscd` | Cookbook containing the template. |
| `service_name` | String | `nscd` | Service resource name. |
| `service_actions` | Array | `[:enable, :start]` | Actions applied to the service in `:create`. |
| `logfile` | String | `/var/log/nscd` | nscd log file path. |
| `threads` | Integer | `4` | Initial worker thread count. |
| `max_threads` | Integer | `32` | Maximum worker thread count. |
| `server_user` | String, nil | `nil` | User to run nscd as. Defaults to `nscd` when present, otherwise `nobody`. |
| `stat_user` | String | `root` | User allowed to request statistics. |
| `debug_level` | Integer | `0` | Debug level. |
| `reload_count` | Integer, String | `5` | Cached entry reload limit. |
| `paranoia` | String | `no` | Enables periodic restart when set to `yes`. |
| `restart_interval` | Integer | `3600` | Restart interval in seconds when paranoia mode is enabled. |
| `databases` | Array | `passwd group hosts services netgroup` | Databases to configure. |
| `cache_settings` | Hash | See resource defaults | Per-database `nscd.conf` cache settings. |

## Examples

```ruby
nscd 'default'
```

```ruby
nscd 'ldap-cache' do
  threads 8
  max_threads 64
  databases %w(passwd group hosts)
  cache_settings(
    passwd: {
      enable_cache: 'yes',
      positive_time_to_live: 300,
      negative_time_to_live: 20,
      suggested_size: 211,
      check_files: 'yes',
      persistent: 'yes',
      shared: 'yes',
      max_db_size: 0x20_00000,
      auto_propagate: 'yes',
    }
  )
end
```

```ruby
nscd 'default' do
  manage_package false
end
```
