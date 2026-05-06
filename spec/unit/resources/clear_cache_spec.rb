# frozen_string_literal: true

require 'spec_helper'

describe 'nscd_clear_cache' do
  step_into :nscd_clear_cache
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      nscd_clear_cache 'clear'
    end

    %w(passwd group hosts services netgroup).each do |database|
      it { is_expected.to run_execute("nscd-clear-#{database}").with(command: "/usr/sbin/nscd -i #{database}") }
    end
  end

  context 'with selected databases' do
    recipe do
      nscd_clear_cache 'clear' do
        databases %w(passwd group)
      end
    end

    it { is_expected.to run_execute('nscd-clear-passwd').with(command: '/usr/sbin/nscd -i passwd') }
    it { is_expected.to run_execute('nscd-clear-group').with(command: '/usr/sbin/nscd -i group') }
    it { is_expected.not_to run_execute('nscd-clear-hosts') }
  end
end
