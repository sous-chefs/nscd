require 'spec_helper'

describe 'nscd::default' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

  it 'installs nscd' do
    expect(chef_run).to install_package('nscd')
  end

  it 'starts and enables the service' do
    expect(chef_run).to start_service('nscd')
    expect(chef_run).to enable_service('nscd')
  end

  it 'creates /etc/nscd.conf using a template' do
    expect(chef_run).to render_file('/etc/nscd.conf')
  end

  it 'notifies restart on template change' do
    resource = chef_run.template('/etc/nscd.conf')
    expect(resource).to notify('service[nscd]').to(:restart)
  end
end
