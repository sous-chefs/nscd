# frozen_string_literal: true

title 'Common nscd Tests'

control 'nscd-service-01' do
  impact 1.0
  title 'Service is enabled and running'

  describe service('nscd') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'nscd-config-01' do
  impact 1.0
  title 'Configuration file is managed'

  describe file('/etc/nscd.conf') do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should match(/^enable-cache\s+passwd yes$/) }
  end
end
