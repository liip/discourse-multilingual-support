# frozen_string_literal: true

require_dependency 'locale_site_setting'

class ::LocaleSiteSetting
  singleton_class.send(:alias_method, :old_supported_locales, :supported_locales)

  def self.supported_locales
    locales = self.old_supported_locales
    # on rake task we want all available language
    return locales if Rake.application.top_level_tasks.present?
    override_locales = SiteSetting.override_locales
    override_locales = override_locales.split('|') if override_locales.is_a? String
    locales_joined = (locales & override_locales)
    locales_joined.length > 0 ? locales_joined : locales
  end
end
