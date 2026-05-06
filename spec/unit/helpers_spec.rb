# frozen_string_literal: true

require 'spec_helper'
require_relative '../../libraries/helpers'

describe NscdCookbook::Helpers do
  describe '.default_cache_settings' do
    it 'returns a copy of the default cache settings' do
      settings = described_class.default_cache_settings
      settings['passwd']['enable_cache'] = 'no'

      expect(described_class::DEFAULT_CACHE_SETTINGS['passwd']['enable_cache']).to eq('yes')
    end
  end

  describe '.normalize_cache_settings' do
    it 'normalizes database and setting keys to strings' do
      expect(described_class.normalize_cache_settings(passwd: { enable_cache: 'no' })).to eq(
        'passwd' => {
          'enable_cache' => 'no',
        }
      )
    end
  end
end
