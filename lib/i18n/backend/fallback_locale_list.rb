require_dependency 'i18n/backend/fallback_locale_list'

class ::FallbackLocaleList
  def [](locale)
    locale = nil unless LocaleSiteSetting.supported_locales.include?(locale)
    fallback_locale = LocaleSiteSetting.fallback_locale(locale)
    locales = [locale, fallback_locale, SiteSetting.default_locale.to_s,
               LocaleSiteSetting.supported_locales.first.to_s].uniq.compact
    locales & LocaleSiteSetting.supported_locales
  end
end
