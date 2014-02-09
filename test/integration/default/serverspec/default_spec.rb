require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'nscd::default' do
  it 'has the nscd service up and running' do
    expect(service('nscd')).to be_enabled
    expect(service('nscd')).to be_running
  end

  it 'creates the /etc/nscd.conf config file' do
    expect(file('/etc/nscd.conf')).to be_file
  end
end
