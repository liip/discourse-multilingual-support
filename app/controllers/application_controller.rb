require_dependency 'application_controller'

class ::ApplicationController
  def set_locale
    if params[:locale].present?
      locale = params[:locale]
    elsif !current_user
      if SiteSetting.set_locale_from_accept_language_header
        locale = locale_from_header
      else
        locale = SiteSetting.default_locale
      end
    else
      locale = current_user.effective_locale
    end

    I18n.locale = if I18n.locale_available?(locale)
                    locale
                  elsif I18n.locale_available?(SiteSetting.default_locale)
                    SiteSetting.default_locale
                  else
                    LocaleSiteSetting.values.first
                  end
    I18n.ensure_all_loaded!
  end
end
