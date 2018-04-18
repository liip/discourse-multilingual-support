require_dependency 'send_system_message'

class ::SendSystemMessage
  alias_method :old_execute, :execute

  def execute(args)

    # Fetch the user locale
    user = User.find_by(id: args[:user_id])
    locale = I18n.locale
    if user.present? and user.locale.present?
      locale = user.locale
    end

    I18n.with_locale(locale) do
      old_execute(args)
    end
  end
end