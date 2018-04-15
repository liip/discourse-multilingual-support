require_dependency 'discourse_single_sign_on'
class ::DiscourseSingleSignOn
  alias_method :old_lookup_or_create_user, :lookup_or_create_user

  def lookup_or_create_user(ip_address = nil)
    user = old_lookup_or_create_user(ip_address)
    if locale && (user.locale.blank? || SiteSetting.sso_overrides_locale)
      user.update_attribute(:locale, locale) unless locale == user.locale
    end
    user
  end
end
