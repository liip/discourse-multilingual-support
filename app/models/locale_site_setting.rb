require_dependency 'locale_site_setting'

class ::LocaleSiteSetting
  singleton_class.send(:alias_method, :old_supported_locales, :supported_locales)

  def self.supported_locales
    override_locales = SiteSetting.override_locales
    override_locales = override_locales.split('|') if override_locales.is_a? String
    locales = self.old_supported_locales
    locales_joined = (locales & override_locales)
    locales_joined.length > 0 ? locales_joined : locales
  end
end
