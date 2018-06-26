require_dependency 'i18n/backend/fallback_locale_list'

class ::FallbackLocaleList
  def [](locale)
    locale = nil unless LocaleSiteSetting.supported_locales.include?(locale)
    fallback_locale = LocaleSiteSetting.fallback_locale(locale)
    locales = [locale, fallback_locale, SiteSetting.default_locale,
               LocaleSiteSetting.supported_locales.first].uniq.compact
    (locales & LocaleSiteSetting.supported_locales) || locales
  end
end
