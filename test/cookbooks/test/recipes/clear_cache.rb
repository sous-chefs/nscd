# frozen_string_literal: true

apt_update 'update' if platform_family?('debian')

nscd 'default'

nscd_clear_cache 'clear-nscd-caches' do
  databases %w(passwd group)
end

nscd_clear_cache 'notify-clear' do
  databases %w(passwd group)
  action :nothing
end

file '/etc/nscd_test.conf' do
  action :touch
  notifies :clear, 'nscd_clear_cache[notify-clear]'
end
