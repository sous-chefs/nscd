# removes databases that aren't supported on your platform
def sanitize_databases(databases)
  sanitized_dbs = databases.to_a # avoid node objects are read only warnings

  sanitized_dbs.delete('netgroup') if platform?('debian') && node['platform_version'].to_i < 8

  if platform_family?('rhel') && node['platform_version'].to_i < 6
    sanitized_dbs.delete('netgroup')
    sanitized_dbs.delete('services')
  end

  sanitized_dbs
end

def nscd_user
  # if the user set the value use that
  return node['nscd']['server_user'] if node['nscd']['server_user']

  Etc.getpwnam('nscd')
  'nscd'
rescue ArgumentError
  'nobody'
end
