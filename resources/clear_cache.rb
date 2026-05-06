# frozen_string_literal: true

provides :nscd_clear_cache
unified_mode true

property :databases, Array, default: %w(passwd group hosts services netgroup)

default_action :clear

action :clear do
  new_resource.databases.each do |cmd|
    execute "nscd-clear-#{cmd}" do
      command "/usr/sbin/nscd -i #{cmd}"
      action :run
    end
  end
end
