# Migration Guide

## Migrating from recipes and attributes

Version 6.0.8 migrates this cookbook to a custom-resource-only API. The legacy `nscd::default` recipe and `default['nscd']` attributes have been removed.

### Before

```ruby
include_recipe 'nscd::default'
```

```ruby
default['nscd']['threads'] = 8
default['nscd']['databases'] = %w(passwd group hosts)
```

### After

```ruby
nscd 'default' do
  threads 8
  databases %w(passwd group hosts)
end
```

## Attribute mapping

| Legacy attribute | Resource property |
| --- | --- |
| `default['nscd']['template_cookbook']` | `template_cookbook` |
| `default['nscd']['package']` | `package_name` |
| `default['nscd']['version']` | `package_version` |
| `default['nscd']['logfile']` | `logfile` |
| `default['nscd']['threads']` | `threads` |
| `default['nscd']['max_threads']` | `max_threads` |
| `default['nscd']['server_user']` | `server_user` |
| `default['nscd']['stat_user']` | `stat_user` |
| `default['nscd']['debug_level']` | `debug_level` |
| `default['nscd']['reload_count']` | `reload_count` |
| `default['nscd']['paranoia']` | `paranoia` |
| `default['nscd']['restart_interval']` | `restart_interval` |
| `default['nscd']['databases']` | `databases` |
| `default['nscd'][SERVICE][SETTING]` | `cache_settings` |

## Cache clearing

The `nscd_clear_cache` resource remains available. It now has explicit `provides`, `unified_mode true`, and `default_action :clear`.
