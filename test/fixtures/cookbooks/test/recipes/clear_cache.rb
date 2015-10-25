include_recipe 'nscd::default'

# clear caches directly
nscd_clear_cache 'clear-nscd-caches' do
  databases %w(passwd group)
end

# use the nothing action with notification
nscd_clear_cache 'notify-clear' do
  databases %w(passwd group)
  action :nothing
end

# touch a file then notify
file '/etc/nscd_test.conf' do
  action :touch
  notifies :clear, 'nscd_clear_cache[notify-clear]'
end
