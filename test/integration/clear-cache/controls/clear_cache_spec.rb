# frozen_string_literal: true

include_controls 'common'

control 'nscd-clear-cache-01' do
  impact 1.0
  title 'Notification test file exists'

  describe file('/etc/nscd_test.conf') do
    it { should be_file }
  end
end
