require 'rails_helper'

describe LocaleSiteSetting do

  before do
    SiteSetting.default_locale = 'de'
    SiteSetting.override_locales = ['fr', 'de', 'it']
    LocaleSiteSetting.reset!
  end

  def core_locales
    pattern = File.join(Rails.root, 'config', 'locales', 'client.*.yml')
    Dir.glob(pattern).map { |x| x.split('.')[-2] }
  end

  def native_locale_name(locale)
    value = LocaleSiteSetting.values.find { |v| v[:value] == locale }
    value[:name]
  end

  describe 'valid_value?' do
    skip 'returns true for a locale that we have translations for' do
      expect(LocaleSiteSetting.valid_value?('en')).to eq(false)
      expect(LocaleSiteSetting.valid_value?('fr')).to eq(true)
    end
  end

  describe 'values filtred' do
    it 'returns all the locales that we want to have' do
      expect(LocaleSiteSetting.values.map { |x| x[:value] }).to include(*SiteSetting.override_locales)
    end

    it 'returns native names' do
      expect(native_locale_name('de')).to eq('Deutsch')
      expect(native_locale_name('fr')).to eq('Français')
      expect(native_locale_name('it')).to eq('Italiano')
    end
  end

end
