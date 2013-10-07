require 'spec_helper'

describe 'nscd::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge(described_recipe) }

  it 'installs nscd' do
    expect(chef_run).to install_package('nscd')
  end

  it 'starts and enables the service' do
    expect(chef_run).to start_service('nscd')
    expect(chef_run).to set_service_to_start_on_boot('nscd')
  end
end
