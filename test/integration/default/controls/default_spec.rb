# frozen_string_literal: true

include_controls 'common'

control 'nscd-package-01' do
  impact 1.0
  title 'nscd package is installed'

  describe package('nscd') do
    it { should be_installed }
  end
end
