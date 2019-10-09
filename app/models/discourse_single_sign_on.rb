# frozen_string_literal: true

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

  def match_email_or_create_user(ip_address)
    # Use a mutex here to counter SSO requests that are sent at the same time w
    # the same email payload
    DistributedMutex.synchronize("discourse_single_sign_on_#{email}") do
      unless user = User.find_by_email(email)
        try_name = name.presence
        try_username = username.presence

        user_params = {
          primary_email: UserEmail.new(email: email, primary: true),
          name: try_name || User.suggest_name(try_username || email),
          username: UserNameSuggester.suggest(try_username || try_name || email),
          locale: locale,
          ip_address: ip_address
        }

        user = User.create!(user_params)

        if SiteSetting.verbose_sso_logging
          Rails.logger.warn("Verbose SSO log: New User (user_id: #{user.id}) Params: #{user_params} User Params: #{user.attributes} User Errors: #{user.errors.full_messages} Email: #{user.primary_email.attributes} Email Error: #{user.primary_email.errors.full_messages}")
        end
      end

      if user
        if sso_record = user.single_sign_on_record
          sso_record.last_payload = unsigned_payload
          sso_record.external_id = external_id
        else
          if avatar_url.present?
            Jobs.enqueue(:download_avatar_from_url,
              url: avatar_url,
              user_id: user.id,
              override_gravatar: SiteSetting.sso_overrides_avatar
            )
          end

          user.create_single_sign_on_record!(
            last_payload: unsigned_payload,
            external_id: external_id,
            external_username: username,
            external_email: email,
            external_name: name,
            external_avatar_url: avatar_url
          )
        end
      end

      user
    end
  end
end
