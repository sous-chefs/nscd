# removes databases that aren't supported on your platform
def sanitize_databases(databases)
  sanitized_dbs = databases.to_a # avoid node objects are read only warnings

  if node['platform'] == 'debian' && node['platform_version'].to_i < 8
    sanitized_dbs.delete('netgroup')
  end

  if node['platform_family'] == 'rhel' && node['platform_version'].to_i < 6
    sanitized_dbs.delete('netgroup')
    sanitized_dbs.delete('services')
  end

  sanitized_dbs
end
