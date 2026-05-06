# frozen_string_literal: true

provides :nscd
unified_mode true

property :package_name, String, default: 'nscd'
property :package_version, [String, nil]
property :manage_package, [true, false], default: true
property :config_path, String, default: '/etc/nscd.conf'
property :template_source, String, default: 'nscd.conf.erb'
property :template_cookbook, String, default: 'nscd'
property :service_name, String, default: 'nscd'
property :service_actions, Array, default: %i(enable start)
property :logfile, String, default: '/var/log/nscd'
property :threads, Integer, default: 4
property :max_threads, Integer, default: 32
property :server_user, [String, nil]
property :stat_user, String, default: 'root'
property :debug_level, Integer, default: 0
property :reload_count, [Integer, String], default: 5
property :paranoia, String, equal_to: %w(yes no), default: 'no'
property :restart_interval, Integer, default: 3600
property :databases, Array, default: lazy { NscdCookbook::Helpers::DEFAULT_DATABASES.dup }
property :cache_settings, Hash, default: lazy { NscdCookbook::Helpers.default_cache_settings }

default_action :create

action_class do
  include NscdCookbook::Helpers

  def nscd_template_settings
    cache_settings = NscdCookbook::Helpers.default_cache_settings
    normalize_cache_settings(new_resource.cache_settings).each do |database, settings|
      cache_settings[database] = cache_settings.fetch(database, {}).merge(settings)
    end

    {
      'logfile' => new_resource.logfile,
      'threads' => new_resource.threads,
      'max_threads' => new_resource.max_threads,
      'stat_user' => new_resource.stat_user,
      'debug_level' => new_resource.debug_level,
      'reload_count' => new_resource.reload_count,
      'paranoia' => new_resource.paranoia,
      'restart_interval' => new_resource.restart_interval,
    }.merge(cache_settings)
  end
end

action :create do
  config_path = new_resource.config_path
  service_name = new_resource.service_name
  template_source = new_resource.template_source
  template_cookbook = new_resource.template_cookbook
  template_settings = nscd_template_settings
  template_databases = sanitize_databases(new_resource.databases)
  template_server_user = nscd_user(new_resource.server_user)

  package new_resource.package_name do
    version new_resource.package_version if new_resource.package_version
    action :install
    only_if { new_resource.manage_package }
  end

  template config_path do
    source template_source
    cookbook template_cookbook
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      settings: template_settings,
      databases: template_databases,
      server_user: template_server_user
    )
    notifies :restart, "service[#{service_name}]"
  end

  service service_name do
    supports restart: true, status: true
    action new_resource.service_actions
  end
end

action :delete do
  service_name = new_resource.service_name
  config_path = new_resource.config_path

  service service_name do
    supports restart: true, status: true
    action %i(stop disable)
  end

  file config_path do
    action :delete
  end

  package new_resource.package_name do
    action :remove
    only_if { new_resource.manage_package }
  end
end
