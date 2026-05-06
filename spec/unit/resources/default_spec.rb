# frozen_string_literal: true

require 'spec_helper'

describe 'nscd' do
  step_into :nscd
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      nscd 'default'
    end

    it { is_expected.to install_package('nscd') }

    it do
      is_expected.to create_template('/etc/nscd.conf').with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it { is_expected.to render_file('/etc/nscd.conf').with_content(%r{^logfile\s+/var/log/nscd$}) }
    it { is_expected.to render_file('/etc/nscd.conf').with_content(/^enable-cache\s+passwd yes$/) }
    it { is_expected.to enable_service('nscd') }
    it { is_expected.to start_service('nscd') }

    it 'notifies the service to restart when the config changes' do
      expect(chef_run.template('/etc/nscd.conf')).to notify('service[nscd]').to(:restart)
    end
  end

  context 'with custom properties' do
    recipe do
      nscd 'custom' do
        package_name 'unscd'
        package_version '1.0.0'
        config_path '/tmp/nscd.conf'
        service_name 'unscd'
        server_user 'daemon'
        databases %w(passwd group)
        cache_settings(
          passwd: {
            enable_cache: 'no',
            positive_time_to_live: 30,
          }
        )
      end
    end

    it { is_expected.to install_package('unscd').with(version: '1.0.0') }
    it { is_expected.to create_template('/tmp/nscd.conf') }
    it { is_expected.to render_file('/tmp/nscd.conf').with_content(/^server-user\s+daemon$/) }
    it { is_expected.to render_file('/tmp/nscd.conf').with_content(/^enable-cache\s+passwd no$/) }
    it { is_expected.to enable_service('unscd') }
    it { is_expected.to start_service('unscd') }
  end

  context 'with package management disabled' do
    recipe do
      nscd 'default' do
        manage_package false
      end
    end

    it { is_expected.not_to install_package('nscd') }
    it { is_expected.to create_template('/etc/nscd.conf') }
  end

  context 'with action delete' do
    recipe do
      nscd 'default' do
        action :delete
      end
    end

    it { is_expected.to stop_service('nscd') }
    it { is_expected.to disable_service('nscd') }
    it { is_expected.to delete_file('/etc/nscd.conf') }
    it { is_expected.to remove_package('nscd') }
  end
end
