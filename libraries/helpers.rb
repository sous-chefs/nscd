# frozen_string_literal: true

require 'etc'

module NscdCookbook
  module Helpers
    DEFAULT_DATABASES = %w(passwd group hosts services netgroup).freeze unless const_defined?(:DEFAULT_DATABASES)

    DEFAULT_CACHE_SETTINGS = {
      'passwd' => {
        'enable_cache' => 'yes',
        'positive_time_to_live' => 600,
        'negative_time_to_live' => 20,
        'suggested_size' => 211,
        'check_files' => 'yes',
        'persistent' => 'yes',
        'shared' => 'yes',
        'max_db_size' => 0x20_00000,
        'auto_propagate' => 'yes',
      },
      'group' => {
        'enable_cache' => 'yes',
        'positive_time_to_live' => 3600,
        'negative_time_to_live' => 60,
        'suggested_size' => 211,
        'check_files' => 'yes',
        'persistent' => 'yes',
        'shared' => 'yes',
        'max_db_size' => 0x20_00000,
        'auto_propagate' => 'yes',
      },
      'hosts' => {
        'enable_cache' => 'yes',
        'positive_time_to_live' => 3600,
        'negative_time_to_live' => 20,
        'suggested_size' => 211,
        'check_files' => 'yes',
        'persistent' => 'yes',
        'shared' => 'yes',
        'max_db_size' => 0x20_00000,
      },
      'services' => {
        'enable_cache' => 'yes',
        'positive_time_to_live' => 28_800,
        'negative_time_to_live' => 20,
        'suggested_size' => 211,
        'check_files' => 'yes',
        'persistent' => 'yes',
        'shared' => 'yes',
        'max_db_size' => 0x20_00000,
      },
      'netgroup' => {
        'enable_cache' => 'no',
        'positive_time_to_live' => 28_800,
        'negative_time_to_live' => 20,
        'suggested_size' => 211,
        'check_files' => 'yes',
        'persistent' => 'yes',
        'shared' => 'yes',
        'max_db_size' => 0x20_00000,
      },
    }.freeze unless const_defined?(:DEFAULT_CACHE_SETTINGS)

    module_function

    def default_cache_settings
      DEFAULT_CACHE_SETTINGS.to_h { |database, settings| [database, settings.dup] }
    end

    def normalize_cache_settings(cache_settings)
      cache_settings.to_h do |database, settings|
        [database.to_s, settings.to_h.transform_keys(&:to_s)]
      end
    end

    def sanitize_databases(databases)
      sanitized_dbs = databases.map(&:to_s)

      sanitized_dbs.delete('netgroup') if platform?('debian') && node['platform_version'].to_i < 8

      if platform_family?('rhel') && node['platform_version'].to_i < 6
        sanitized_dbs.delete('netgroup')
        sanitized_dbs.delete('services')
      end

      sanitized_dbs
    end

    def nscd_user(server_user = nil)
      return server_user if server_user

      Etc.getpwnam('nscd')
      'nscd'
    rescue ArgumentError
      'nobody'
    end
  end
end
